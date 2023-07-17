import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        'Confirm'.text.fontFamily(bold).color(darkFontGrey).size(18).make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit".text.color(darkFontGrey).size(16).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(title: "YES",textcolor: whiteColor,buttoncolor: redColor,onpress: (){
              //exit the app
              SystemNavigator.pop();
            }),
            ourButton(title: "NO",textcolor: whiteColor,buttoncolor: redColor,onpress: (){Navigator.pop(context);}),
          ],
        )
      ],
    ).box.roundedSM.color(lightGrey).padding(EdgeInsets.all(12)).make(),
  );
}