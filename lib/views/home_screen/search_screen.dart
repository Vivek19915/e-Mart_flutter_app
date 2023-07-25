import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/product_controller.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

import '../../category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {

    var productController = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: title.toString().text.color(darkFontGrey).fontFamily(bold).make(),
      ),


      //using fluter builder because whatever product shown here will shown once and not update frequently therofore using future builder and save ram
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title) ,
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasData == false){
            return Center(child: loadingIndicator(),);
          }
          else if(snapshot.data!.docs.isEmpty){
            return "Sorry no such products available".text.bold.black.size(18).makeCentered();
          }
          else{

            var data = snapshot.data!.docs;
            var filteredData = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();


            return Container(
              margin: EdgeInsets.all(12),
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 4,crossAxisSpacing: 4,mainAxisExtent: 270),
                  itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(filteredData[index]['p_imgs'][0],height: 140,width:140,fit: BoxFit.cover,).box.roundedSM.clip(Clip.antiAlias).make(),
                        20.heightBox,
                        filteredData[index]['p_name'].toString().text.color(fontGrey).make(),
                        10.heightBox,
                        filteredData[index]['p_price'].toString().numCurrency.text.color(redColor).size(20).make(),
                      ],
                    ).box.white.roundedSM.shadowSm.margin(EdgeInsets.all(6)).padding(EdgeInsets.all(12)).make().
                    onTap(() {
                      productController.checkIsFav(filteredData[index]);
                      Get.to(()=>ItemDetails(title: filteredData[index]['p_name'].toString(),image: filteredData[index]['p_imgs'][0],price: filteredData[index].toString(),data: filteredData[index]));     //this data passing is OPOPoopp

                    });
                  }),
            );
          }
        },

      ),
    );
  }
}
