

import 'package:get/get.dart';

import '../../consts/consts.dart';


Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title1.toString().text.fontFamily(semibold).make(),
          d1.toString().text.fontFamily(semibold).color(redColor).make(),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          title2.toString().text.fontFamily(semibold).make(),
          d2.toString().text.fontFamily(semibold).color(redColor).make(),
        ],
      )
    ],
  ).box.padding(EdgeInsets.symmetric(horizontal: 10,vertical: 10)).roundedSM.make();
}