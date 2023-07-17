import 'package:e_mart/category_screen/category_details.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/consts/list.dart';
import 'package:e_mart/controller/product_controller.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var productController = Get.put(ProductController());

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: categoriesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200),
              itemBuilder: (context,index){
                return Column(
                  children: [
                    Image.asset(categoriesImages[index],height: 120,width: 200,fit: BoxFit.cover,),
                    10.heightBox,
                    categoriesList[index].text.align(TextAlign.center).make(),
                  ],
                ).box.roundedSM.white.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                  productController.getSubCategories(title: categoriesList[index]);
                  Get.to(()=>CategoryDetails(title: categoriesList[index]));            //🔥🔥🔥 jis par bhi click karege uska cayergory details open hi jayega
                });                  //clip is used to clip the image
              }),
        ),
      ),
    );
  }
}
