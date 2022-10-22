import 'dart:developer';

import 'package:agency31_app/controller/authentication.dart';
import 'package:agency31_app/ui/screens/home/home.dart';
import 'package:agency31_app/ui/screens/registration/sign_in.dart';
import 'package:agency31_app/utils/material_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'utils/shared_prefrences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log(message.data.toString(), name: "onBackgroundMessage message");

  log("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
      .then((value) => Get.put(AuthController())); //dependency injection
  var token = await FirebaseMessaging.instance.getToken();
  log(token.toString(), name: "token");
  FirebaseMessaging.onMessage.listen((event) {
    log(event.data.toString(), name: "onMessage event");
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    log(event.data.toString(), name: "onMessageOpenedApp event");
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await MySharedPreferences.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _toggleScreen() {
    if (MySharedPreferences.isLogIn) {
      return const HomeScreen();
    } else if (!MySharedPreferences.isLogIn) {
      return const SignInScreen();
    } else {
      return const SignInScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // initialBinding: HomeBinding(),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('en', 'US'),
        ],
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        theme: AppThemeData().materialTheme,
        home: _toggleScreen(),
      );
    });
  }
}
