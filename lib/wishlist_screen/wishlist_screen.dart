

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

import '../widgets_common/our_button.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Your Wishlist Items".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),

      body: StreamBuilder(
        stream: FirestoreServices.getWishlist(),
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData == false){
            return Center(child: loadingIndicator(),);
          }
          else if(snapshot.data!.docs.isEmpty){
            return "No products Yet!".text.color(darkFontGrey).makeCentered();
          }
          else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true  ,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context , int index){
                      return ListTile(
                        leading: Image.network(data[index]['p_imgs'][0],width: 100,fit: BoxFit.cover,).box.roundedSM.clip(Clip.antiAlias).make(),
                        title: (data[index]["p_name"].toString() +")").toString().text.size(16).fontFamily(semibold).make(),
                        subtitle: data[index]['p_price'].toString().numCurrency.text.color(redColor).size(14).fontFamily(semibold).make(),
                        trailing: Icon(Icons.favorite_outlined ,color: redColor,)
                            .onTap(() {
                              //remove from favroite
                              FirestoreServices.removeFromWishlist(data[index].id);

                        }),

                      );
                    }
                ).box.color(Colors.grey.shade300).roundedSM.make().expand(),

              ],
            ).box.padding(EdgeInsets.all(8)).make();
          }
        },
      ),
    );
  }
}
