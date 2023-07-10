import 'package:e_mart/views/auth_screen/signup_screen.dart';
import 'package:e_mart/views/home_screen/home_screen.dart';
import 'package:e_mart/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await means jab tak firebase initilise na ho jaye tab tak runapp na kare
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //sicnce we are using getx --> we have to change material app to getmaterial app
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            iconTheme:IconThemeData(color: darkFontGrey),          //all icons in appbar will get this color unless we change it
        ),
        fontFamily: regular
      ),
      home: const SplashScreen(),
    );
  }
}
