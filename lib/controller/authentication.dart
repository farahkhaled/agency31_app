import 'dart:developer';
import 'package:agency31_app/services/database_service.dart';
import 'package:agency31_app/ui/screens/home/home.dart';
import 'package:agency31_app/ui/screens/registration/sign_in.dart';
import 'package:agency31_app/utils/base/colors.dart';
import 'package:agency31_app/utils/shared_prefrences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  late Rx<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    //our user would be notified
    user.bindStream(auth.userChanges());
    //user change (login, logout) => execute initscreen
    ever(user, _initscreen);
  }

  _initscreen(User? user) {
    if (user == null) {
      log("login page");
      Get.offAll(() => const SignInScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user.value = userCredential.user;
        log(user.value?.email ?? 'email');
        log(user.value?.phoneNumber ?? 'phoneNumber');
        log(user.value?.uid ?? 'uid');
        if (user.value != null) {
          MySharedPreferences.isLogIn = true;
        }
        if (user.value != null) {
          await DatabaseServices(user.value?.uid).saveUserData(user.value!);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          Get.snackbar(
            'Error',
            'The account already exists with a different credential',
            isDismissible: true,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: MyColors.secondary,
          );
        } else if (e.code == 'invalid-credential') {
          // handle the error here
          Get.snackbar(
            'Error',
            'Error occurred while accessing credentials. Try again 1',
            isDismissible: true,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: MyColors.secondary,
          );
        }
      } catch (e) {
        // handle the error here
        Get.snackbar(
          'Error',
          'Error occurred $e',
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: MyColors.secondary,
        );
      }
    }
    return user.value;
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      MySharedPreferences.isLogIn = false;
    } catch (e) {
      Get.snackbar('Error', 'Error signing out. Try again.');
    }
  }
}
