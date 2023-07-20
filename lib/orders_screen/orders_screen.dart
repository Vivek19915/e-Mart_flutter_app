

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/orders_screen/orders_details.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Your Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),

      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData == false){
            return Center(child: loadingIndicator(),);
          }
          else if(snapshot.data!.docs.isEmpty){
            return "No orders Yet!".text.color(darkFontGrey).makeCentered();
          }
          else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (BuildContext context , int index){
                  return ListTile(
                    leading: (index+1).toString().text.bold.color(redColor).make(),
                    title: ("Order No: " + data[index]['order_code']).toString().text.fontFamily(semibold).color(redColor).make(),
                    subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(semibold).color(darkFontGrey).make(),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: (){
                        Get.to(()=> OrdersDetails(data: data[index],));
                      },
                    ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
