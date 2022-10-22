import 'dart:developer';
import 'package:agency31_app/controller/authentication.dart';
import 'package:agency31_app/ui/screens/chat/chat_room.dart';
import 'package:agency31_app/ui/widgets/custom_text_field.dart';
import 'package:agency31_app/utils/base/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController searchCtrl;

  bool _isLoading = false;
  Map<String, dynamic> userMap = {};

  @override
  void initState() {
    searchCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void onSearch() async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: searchCtrl.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (value.docs[0].data().isNotEmpty) {
          userMap = value.docs[0].data();
        }
      }
    });
    setState(() {
      _isLoading = false;
    });
    log(userMap.toString(), name: "userMap");
    // searchCtrl.clear();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          elevation: 0.5,
          centerTitle: true,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.only(
                    left: 0.025.sw, top: 0.05.sh, right: 0.025.sw),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: searchCtrl,
                      obscureText: false,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (searchCtrl.text.length > 5) {
                            onSearch();
                          }
                          if (searchCtrl.text.isEmpty) {
                            setState(() {
                              userMap = {};
                            });
                          }
                        },
                        child: const Icon(
                          Icons.search,
                          color: MyColors.secondary,
                        ),
                      ),
                      label: "Search",
                    ),
                    userMap.isNotEmpty
                        ? ListTile(
                            onTap: () {
                              Get.to(() => ChatRoom(userMap: userMap));
                            },
                            title: Text(userMap["fullName"]),
                            leading: CircleAvatar(
                              child: Image.network(userMap["photoUrl"]),
                            ),
                            subtitle: Text(userMap["email"]),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.chat),
                            ),
                          )
                        : Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection("users")
                                    .where("uid",
                                        isNotEqualTo:
                                            AuthController.to.user.value!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.docs.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.all(5),
                                          color: MyColors.tertiary
                                              .withOpacity(0.3),
                                          child: ListTile(
                                            onTap: () {
                                              Map<String, dynamic> userMap =
                                                  snapshot.data?.docs[index]
                                                          .data()
                                                      as Map<String, dynamic>;
                                              Get.to(() =>
                                                  ChatRoom(userMap: userMap));
                                            },
                                            leading: Image.network(snapshot
                                                .data?.docs[index]["photoUrl"]),
                                            title: Text(snapshot
                                                .data?.docs[index]["fullName"]),
                                            subtitle: Text(snapshot
                                                .data?.docs[index]["email"]),
                                            trailing: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.chat),
                                            ),
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
                          )
                  ],
                ),
              ),
      ),
    );
  }
}
