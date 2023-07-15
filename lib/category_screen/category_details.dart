import 'package:e_mart/category_screen/item_details.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/consts/list.dart';
import 'package:e_mart/controller/product_controller.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key , required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var productController = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          children: [
            20.heightBox,
            Row(
              children: List.generate(productController.subcat.length,
                      (index) => productController.subcat[index].toString().text.color(fontGrey).fontFamily(bold).make().box.white.padding(EdgeInsets.all(12)).height(40).roundedSM.margin(EdgeInsets.symmetric(horizontal: 6)).make(),
              ).toList(),
            ).scrollHorizontal(physics: BouncingScrollPhysics()),
            20.heightBox,
            
            //item containor
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12),
                child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: featuredProductImages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 4,crossAxisSpacing: 4,mainAxisExtent: 270),
                    itemBuilder: (context,index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(featuredProductImages[index],width: 150,fit: BoxFit.fill,),
                          10.heightBox,
                          featuredProducttitles[index].text.color(fontGrey).make(),
                          10.heightBox,
                          featuredProductPrice[index].text.color(redColor).size(24).make(),
                        ],
                      ).box.white.roundedSM.shadowSm.margin(EdgeInsets.all(6)).make().onTap(() {

                        Get.to(()=>ItemDetails(title: featuredProducttitles[index],image: featuredProductImages[index],price: featuredProductPrice[index],));

                      });
                    }),
              ),
            )
          ],
        ),
      )
    );
  }
}
