import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/cart_controller.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';
import 'package:e_mart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.white,
        title: "Shopping Cart".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){

          if(snapshot.hasData == false){
            //snapshot dont find any data
            return Center(child: loadingIndicator(),);
          }
          else if(snapshot.data!.docs.isEmpty == true){
            // snapshot has data but it is empty
            return Center(child: "Cart is Empty".text.color(darkFontGrey).make());
          }
          else {
            // means data is present on firebase for cart
            var data = snapshot.data!.docs;
            cartController.calulate(data);


            return Column(
              children: [
                ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context , int index){
                      return ListTile(
                        leading: Image.network(data[index]['img'],width: 100,fit: BoxFit.cover,).box.roundedSM.clip(Clip.antiAlias).make(),
                        title: (data[index]["title"] +" (x" + data[index]["quantity"].toString() +")").toString().text.size(16).fontFamily(semibold).make(),
                        subtitle: data[index]['total_price'].toString().numCurrency.text.color(redColor).size(14).fontFamily(semibold).make(),
                        trailing: Icon(Icons.delete,color: redColor,)
                        .onTap(() {
                          //deletion of that item from firebase also
                          FirestoreServices.deleteDocument(data[index].id);
                        }),

                      );
                    }
                ).box.color(Colors.grey.shade300).make().expand(),

                Obx(
                      ()=> Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price".text.fontFamily(semibold).color(darkFontGrey).make(),
                    "${cartController.total_price.value}".numCurrency.text.fontFamily(semibold).color(redColor).make(),
                    ],
                  ).box.color(lightGolden).bottomRounded(value: 12).padding(EdgeInsets.all(12)).make(),
                ),

                //proceed to shipping Button
                ourButton(
                    title: "Proceed to shipping",
                    onpress: (){},
                    buttoncolor: redColor,
                    textcolor: whiteColor
                ).box.width(Get.width-60).make()
              ],
            ).box.padding(EdgeInsets.all(8)).make();
          }

        }

      )
    );
  }
}



