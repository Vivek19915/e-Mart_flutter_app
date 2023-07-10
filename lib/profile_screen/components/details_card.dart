
import 'package:e_mart/consts/consts.dart';

Widget detailsCard({width , String ? title , String ? count}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      Align(alignment: Alignment.center,child: title!.text.color(darkFontGrey).make()),
    ],
  ).box.white.roundedSM.width(width).height(80).padding(EdgeInsets.all(8)).margin(EdgeInsets.symmetric(horizontal: 4)).make();
}