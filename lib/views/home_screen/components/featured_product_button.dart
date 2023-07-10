import 'package:e_mart/consts/consts.dart';

Widget featuredProductButton({image , String? title , String ? price}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(image,width: 180,fit: BoxFit.fill,),
      10.heightBox,
      title!.text.color(fontGrey).make(),
      10.heightBox,
      price!.text.color(redColor).size(24).make(),
    ],
  ).box.padding(EdgeInsets.all(12)).roundedSM.white.shadowSm.margin(EdgeInsets.symmetric(horizontal: 6)).make();
}