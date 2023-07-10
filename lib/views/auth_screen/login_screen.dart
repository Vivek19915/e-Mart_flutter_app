import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/auth_screen/signup_screen.dart';
import 'package:e_mart/views/home_screen/home.dart';
import 'package:e_mart/widgets_common/applogo_widget.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';
import 'package:e_mart/widgets_common/custom_textfield.dart';
import 'package:e_mart/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';

import '../../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}): super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //controller
    var controller = Get.put(AuthController());
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            //making responsive spacing using velocity x
            (context.screenHeight*0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Login to $appname".text.white.size(14).semiBold.make(),
            10.heightBox,
            //coloumn ka parent container --> velocityx
            Obx(
              ()=> Column(
                children: [
                  customTextFiled(title: "Email" , hint: "abc@gmail.com",controller: emailController),
                  customTextFiled(title: "Password" , hint: "************",b:true,controller: passwordController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: forgetPass.text.make())),
                  10.heightBox,

                  //showing circular loading before login
                  if(controller.isloading.value==true)  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),)
                  else  ourButton(title: login ,buttoncolor: redColor,textcolor: whiteColor,onpress: ()async {
                    controller.isloading(true);           //for circular animation
                    await controller.loginMethod(context: context,useremail: emailController.text,userpassword: passwordController.text)
                    .then((value) {
                      // print(value);
                      if(value != null){
                       VxToast.show(context, msg: "Logged in Succesful");
                       Get.offAll(()=>const Home());
                      }
                      else {
                        controller.isloading(false);
                        print("error aa gaya h ");
                      }
                    });
                  }).box.width((context.screenWidth)-50).make(),
                  10.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  10.heightBox,
                  ourButton(title: signup ,buttoncolor: lightGolden,textcolor: redColor,onpress: (){
                    Get.to(()=>signupScreen());
                  }).box.width((context.screenWidth)-50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar( backgroundColor : lightGrey, child: Image.asset(icFacebookLogo,width: 30,)).paddingAll(12),
                      CircleAvatar(backgroundColor : lightGrey, child: Image.asset(icGoogleLogo,width: 30,)).paddingAll(12),
                      CircleAvatar(backgroundColor : lightGrey, child: Image.asset(icTwitterLogo,width: 30,)).paddingAll(12),
                    ],
                  ).scrollHorizontal()
                ],
              ).box.padding(EdgeInsets.all(16)).rounded.width(context.screenWidth-70).white.shadow.make(),
            ),
          ],
        ),
      ),
    ));
  }
}
