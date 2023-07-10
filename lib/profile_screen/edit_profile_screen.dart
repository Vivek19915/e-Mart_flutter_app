import 'dart:io';

import 'package:e_mart/controller/change_profile_controller.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';
import 'package:e_mart/widgets_common/custom_textfield.dart';
import 'package:e_mart/widgets_common/our_button.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../consts/consts.dart';

class EditProfileScreen extends StatelessWidget {

  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    //controller --- profile conroller
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        // appBar: AppBar(),
        // obx -->used to change state in stateless widget  🔥🔥🔥🔥🔥🔥🔥🔥🔥
        body: Obx(
          ()=> SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                //changing image when already uploaded by user

                //if data image url and controller path is empty
                data['imageUrl']=='' && controller.profilrIMgPath.isEmpty
                ? Image.asset(imgProfile2,width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                  //if data image url is not empty and controller path is empty
                  : data['imageUrl']!='' && controller.profilrIMgPath.isEmpty
                    ? Image.network(data['imageUrl'],width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                      //both are not empty
                      : Image.file(File(controller.profilrIMgPath.value),width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),


                10.heightBox,
                ourButton(buttoncolor: redColor,onpress: (){
                  controller.changeImage(context);
                },textcolor: whiteColor , title: "Change Profile"),
                Divider(),
                20.heightBox,
                customTextFiled(
                    hint: namehint,
                    title: name,
                    b: false,
                  controller: controller.nameController
                ),
                10.heightBox,
                customTextFiled(
                    title: "New Password" ,
                    hint: "*********" ,
                    b: false ,
                  controller: controller.passController
                ),
                20.heightBox,

                //updating of user data
                if(controller.isloading.value == true) CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),)
                else ourButton(buttoncolor: redColor,onpress: () async{
                  controller.isloading(true);
                  await controller.uploadProfileImage();
                  await controller.updateProfile(imgUrl: controller.profileImageLink ,name: controller.nameController.text ,password: controller.passController.text );
                  VxToast.show(context, msg: "Updated");
                },textcolor: whiteColor , title: "Save Changes").box.width(context.screenWidth/1).make(),

              ],
            ).scrollVertical().box.shadowSm.padding(EdgeInsets.all(16)).margin(EdgeInsets.only(top: 50,left: 20,right: 20)).rounded.white.make(),
          ),
        ),
      )
    );
  }
}
