import 'dart:developer';
import 'package:agency31_app/controller/authentication.dart';
import 'package:agency31_app/model/message.dart';
import 'package:agency31_app/network/notification_api.dart';
import 'package:agency31_app/ui/widgets/custom_text_field.dart';
import 'package:agency31_app/utils/base/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key, required this.userMap});
  final Map<String, dynamic> userMap;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late TextEditingController messageCtrl;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    messageCtrl = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    messageCtrl.dispose();
    super.dispose();
  }

  void onSendMessage({
    required String recieverId,
    required String dateTime,
    required String text,
    required String deviceToken,
    required String senderName,
  }) async {
    MessageModel message = MessageModel(
      senderID: AuthController.to.user.value?.uid,
      recieverId: recieverId,
      dateTime: dateTime,
      text: text,
    );

    await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthController.to.user.value?.uid)
        .collection("chat")
        .doc(recieverId)
        .collection("messages")
        .add(message.toJson())
        .then((value) => log("sent"));

    await FirebaseFirestore.instance
        .collection("users")
        .doc(recieverId)
        .collection("chat")
        .doc(AuthController.to.user.value?.uid)
        .collection("messages")
        .add(message.toJson())
        .then((value) => log("sent"));

    messageCtrl.clear();
    NotificationApi.sendNotification(
        token: deviceToken, sender: senderName, text: text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.userMap["fullName"]),
          elevation: 0.5,
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        bottomSheet: Container(
          color: MyColors.primary.withOpacity(0.1),
          width: 1.sw,
          height: 0.1.sh,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: messageCtrl,
                  hintText: "send message",
                ),
              ),
              IconButton(
                onPressed: () {
                  if (messageCtrl.text.isNotEmpty) {
                    onSendMessage(
                      dateTime: DateTime.now().toString(),
                      recieverId: widget.userMap["uid"],
                      text: messageCtrl.text,
                      deviceToken: widget.userMap["deviceToken"],
                      senderName:
                          AuthController.to.user.value?.displayName ?? "",
                    );
                  }
                },
                icon: const Icon(Icons.send),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 0.11.sh),
                height: 0.89.sh,
                color: MyColors.tertiary.withOpacity(0.2),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection("users")
                      .doc(AuthController.to.user.value?.uid)
                      .collection("chat")
                      .doc(widget.userMap["uid"])
                      .collection("messages")
                      .orderBy("dateTime", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: snapshot.data?.docs[index]["senderID"] ==
                                    AuthController.to.user.value?.uid
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: snapshot.data?.docs[index]
                                          ["senderID"] !=
                                      AuthController.to.user.value?.uid
                                  ? const BorderRadiusDirectional.only(
                                      topStart: Radius.circular(15),
                                      topEnd: Radius.circular(15),
                                      bottomEnd: Radius.circular(15),
                                    )
                                  : const BorderRadiusDirectional.only(
                                      topStart: Radius.circular(15),
                                      topEnd: Radius.circular(15),
                                      bottomStart: Radius.circular(15),
                                    ),
                              color: MyColors.secondary.withOpacity(0.5),
                            ),
                            child: Text(
                              snapshot.data?.docs[index]["text"],
                            ),
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
