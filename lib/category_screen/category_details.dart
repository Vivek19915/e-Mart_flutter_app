import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/category_screen/item_details.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/consts/list.dart';
import 'package:e_mart/controller/product_controller.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

import '../widgets_common/loading_indicator.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key , required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var productController = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: title!.text.fontFamily(bold).white.make(),
        ),
        //for real time changes we use stream builder and fetch data from firebase
        body: StreamBuilder(
            stream: FirestoreServices.getProduct(title),            //get all info according to p_category
            builder: (BuildContext context , AsyncSnapshot<QuerySnapshot>snapshot) {
              if(snapshot.hasData == false){
                return Center(child: loadingIndicator());
              }
              else if(snapshot.data!.docs.isEmpty){
                return Center(child: "No Products Found".text.color(darkFontGrey).make());
              }
              else {
                //data in not empty

                var data = snapshot.data!.docs;

                return Column(
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
                            itemCount: data.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 4,crossAxisSpacing: 4,mainAxisExtent: 270),
                            itemBuilder: (context,index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //fecting all things from databse and showing here

                                  Image.network(data[index]['p_imgs'][0],height: 140,fit: BoxFit.fill,).box.roundedSM.clip(Clip.antiAlias).make(),
                                  20.heightBox,
                                  data[index]['p_name'].toString().text.color(fontGrey).make(),
                                  10.heightBox,
                                  data[index]['p_price'].toString().numCurrency.text.color(redColor).size(20).make(),
                                ],
                              ).box.white.roundedSM.shadowSm.margin(EdgeInsets.all(6)).padding(EdgeInsets.all(12)).make().
                              onTap(() {
                                productController.checkIsFav(data[index]);
                                Get.to(()=>ItemDetails(title: data[index]['p_name'].toString(),image: data[index]['p_imgs'][0],price: featuredProductPrice[index].toString(),data: data[index]));     //this data passing is OPOPoopp

                              });
                            }),
                      ),
                    )
                  ],
                );
              }

            })
      )
    );
  }
}
