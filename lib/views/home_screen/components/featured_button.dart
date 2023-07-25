import 'package:e_mart/category_screen/category_details.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title , image}){
  //this is actually returning a constinor that contains row --->velcocity x box .make is used
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(image,width: 60,fit: BoxFit.fill),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.white.width(200).roundedSM.outerShadowSm.padding(EdgeInsets.all(12)).margin(EdgeInsets.symmetric(horizontal: 6)).make().onTap(() {
    Get.to(()=>CategoryDetails(title: title));
  });
}
