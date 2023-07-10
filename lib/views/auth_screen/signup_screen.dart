import 'package:e_mart/controller/auth_controller.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';
import '../home_screen/home.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  bool ? ischeck = false;
  //controller
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetyprController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
            children: [
              //making responsive spacing using velocity x
              (context.screenHeight*0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Join the $appname".text.white.size(14).semiBold.make(),
              10.heightBox,
              //coloumn ka parent container --> velocityx
              Column(
                children: [
                  customTextFiled(title: name, hint: namehint,controller: nameController),
                  customTextFiled(title: "Email" , hint: "abc@gmail.com",controller: emailController),
                  customTextFiled(title: "Password" , hint: "************",b:true,controller: passwordController),
                  customTextFiled(title:retypepass , hint: "************",b:true,controller: passwordRetyprController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: forgetPass.text.make())),
                  10.heightBox,
                  //adding checkbox
                  Row(
                    children: [
                      Checkbox(
                          checkColor: redColor,
                          value: ischeck,
                          onChanged: (newvalue){
                            setState(() {
                              ischeck=newvalue;
                            });
                          }
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(text: TextSpan(
                          children: [
                            TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(color: fontGrey),
                            ),
                            TextSpan(
                              text: "Terms & Condition ",
                              style: TextStyle(color: redColor,fontFamily: bold),
                            ),
                            TextSpan(
                              text: "and ",
                              style: TextStyle(color: fontGrey),
                            ),
                            TextSpan(
                              text: "Privacy Policy.",
                              style: TextStyle(color: redColor,fontFamily: bold),
                            ),
                          ]
                        )),
                      ),
                    ],
                  ),
                  10.heightBox,
                  if(controller.isloading==true)  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),)
                  else ourButton(title: signup ,buttoncolor: ischeck==true? redColor:lightGrey,textcolor: whiteColor,
                      onpress: () async {
                        controller.isloading(true);
                        if (ischeck == true) {
                          try {
                            await controller.signupMethod(context: context,
                                useremail: emailController.text,
                                userpassword: passwordController.text)
                                .then((value) {
                              return controller.storeUserData(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: passwordController.text);
                            }).then((value) {
                              // VxToast.show(context, msg: "Logged in Succesfully");
                              Get.offAll(() => const Home());
                            });
                          }
                          catch (e) {
                            controller.isloading(false);
                            auth.signOut();
                            VxToast.show(context, msg: e.toString());
                          }
                        }
                      }
                  ).box.width((context.screenWidth)-50).make(),
                  10.heightBox,
                  //adding gesture using velocity x
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Already have an account? ".text.make(),
                      "Log In".text.color(redColor).bold.make().onTap(() {
                        Get.back();
                        print("Done");
                      })
                    ],
                  )
                ],
              ).box.padding(EdgeInsets.all(16)).rounded.width(context.screenWidth-70).white.shadow.make(),
            ],
          ),
        ),
      ),
    );
  }
}
