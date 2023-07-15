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

  //constructor--->
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    //controller --- profile conroller
    var controller = Get.find<ProfileController>();        //-->using previous profile controller so values fill pass on this screen also

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
                ? Image.asset(imgProfile2,width: 80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).width(80).make()
                  //if data image url is not empty and controller path is empty
                  : data['imageUrl']!='' && controller.profilrIMgPath.isEmpty
                    ? Image.network(data['imageUrl'],width: 80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).width(80).make()
                      //both are not empty
                      : Image.file(File(controller.profilrIMgPath.value),width: 80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).width(80).make(),


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
                    title: "Old Password" ,
                    hint: "*********" ,
                    b: true,
                    controller: controller.oldpassController
                ),
                10.heightBox,
                customTextFiled(
                    title: "New Password" ,
                    hint: "*********" ,
                    b: true ,
                    controller: controller.newpassController
                ),
                20.heightBox,

                //updating of user data
                if(controller.isloading.value == true) CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),)
                else ourButton(buttoncolor: redColor,onpress: () async{
                  controller.isloading(true);

                  if(controller.profilrIMgPath.value.isNotEmpty){
                    //means user change the profile image
                    await controller.uploadProfileImage();
                  }
                  else {
                    //if user dont change the profile image --- then give it previosu fprofile image
                    controller.profileImageLink = data['imageUrl'];
                  }

                  //if user only want to update image thenwe should not ask it for old pass
                  if(controller.oldpassController.text.length == 0 && controller.newpassController.text.length==0 ){
                    await controller.updateProfile(
                        imgUrl: controller.profileImageLink ,
                        name: controller.nameController.text,
                        password: data['password']
                    );
                  }

                  //if old password matches then update the new password
                  else if(controller.oldpassController.text == data['password']){
                    await controller.changeAuthPassword(
                        email: data['email'],
                        oldpass: controller.oldpassController.text,
                        newpass: controller.newpassController.text
                    );

                    await controller.updateProfile(
                        imgUrl: controller.profileImageLink ,
                        name: controller.nameController.text ,
                        password: controller.newpassController.text
                    );
                    VxToast.show(context, msg: "Updated");
                  }

                  else if(controller.oldpassController.text != data['password']){
                    VxToast.show(context, msg: "Enter correct old password");
                    controller.isloading(false);
                  }

                },textcolor: whiteColor , title: "Save Changes").box.width(context.screenWidth/1).make(),

              ],
            ).scrollVertical().box.shadowSm.padding(EdgeInsets.all(16)).margin(EdgeInsets.only(top: 50,left: 20,right: 20)).rounded.white.make(),
          ),
        ),
      )
    );
  }
}
