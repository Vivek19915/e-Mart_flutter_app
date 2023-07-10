import 'package:e_mart/consts/colors.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/auth_screen/login_screen.dart';
import 'package:e_mart/views/home_screen/home.dart';
import 'package:e_mart/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //creating ethod to change splash screen to login screen
  changeScreen(){
    //first we have to create delay for splash screen
    Future.delayed(Duration(seconds: 1),(){
      //using getX to navigate
      // Get.to(()=> LoginScreen());

      //if user is already logwd in previously
      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          Get.to(()=>LoginScreen());
        }
        else{
          //user is already logged in h -->then direct it to home page
          Get.to(()=>Home());
        }
      });
    });
  }


  //and this funtcion mjust be call as soon as this state start
  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
          child: Column(
            children: [
              Align(
                  alignment:Alignment.topLeft,
                  child: Image.asset(icSplashBg,width: 300,)
              ),
              SizedBox(height: 20,),   // velocity -->20.heightBox
              applogoWidget(),
              10.heightBox,
              appname.text.fontFamily(bold).white.size(22).make() ,      // using velocity x
              10.heightBox,
              "Version 1.0.0".text.fontFamily(semibold).white.make(),
              Spacer(),
              "@Vivek_Dev".text.fontFamily(bold).white.size(12).make(),
              30.heightBox,
            ],
          ),
        ),
      );

  }
}
