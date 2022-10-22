import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DatabaseServices {
  final String? uid;

  DatabaseServices(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future saveUserData(User user) async {
    var token = await FirebaseMessaging.instance.getToken();
    return await userCollection.doc(uid).set({
      "fullName": user.displayName,
      "email": user.email,
      "photoUrl": user.photoURL,
      "uid": user.uid,
      "deviceToken": token
    });
  }

  Future getUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
