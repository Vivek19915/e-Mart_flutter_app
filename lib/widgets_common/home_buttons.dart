import 'package:e_mart/consts/consts.dart';

Widget homeButtons({String ? title, icon ,height, width, onpress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,width: 26,),
      10.heightBox,
      title!.text.semiBold.color(fontGrey).make(),
    ],
  ).box.rounded.white.width(width).height(height).shadowSm.make();
}