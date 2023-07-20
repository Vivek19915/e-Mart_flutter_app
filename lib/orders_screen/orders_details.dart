import 'package:e_mart/consts/consts.dart';

import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/orders_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;
import 'components/order_place_details.dart';

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Order Details".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                orderStatus(color: redColor, title: "Placed", icon: Icons.done, showDone: data['order_placed']),
                orderStatus(color: Colors.blue, title: "Confirmed", icon: Icons.thumb_up, showDone: data['order_confirmed']),
                orderStatus(color: Colors.yellow, title: "Dispatched", icon: Icons.car_crash, showDone: data['order_on_delivery']),
                orderStatus(color: Colors.purple, title: "Delivered", icon: Icons.done_all_rounded, showDone: data['order_confirmed']),

                Divider(),
                10.heightBox,


                Column(
                  children: [
                    orderPlaceDetails(title1: "Order No",title2: "Shipping Method",d1:data['order_code'],d2:data['shipping_method']),
                    orderPlaceDetails(
                        title1: "Order Date",
                        title2: "Payment Method",
                        d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
                        d2: data['payment_method']
                    ),
                    orderPlaceDetails(
                        title1: "Payment Status",
                        title2: "Delivery Status",
                        d1:"Unpaid",
                        d2: "Order Placed"
                    ),

                    Divider(),

                    //more details and total amunt
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            data['order_by_name'].toString().text.make(),
                            data['order_by_email'].toString().text.make(),
                            data['order_by_address'].toString().text.make(),
                            data['order_by_city'].toString().text.make(),
                            data['order_by_state'].toString().text.make(),
                            data['order_by_phone'].toString().text.make(),
                            data['order_by_postalcode'].toString().text.make(),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            "Total Amount".text.fontFamily(semibold).make(),
                            data['total_amount'].toString().text.fontFamily(bold).color(redColor).make(),


                          ],
                        )
                      ],
                    ).box.margin(EdgeInsets.symmetric(horizontal: 10)).padding(EdgeInsets.symmetric(vertical: 10)).make(),
                  ],
                ).box.color(lightGrey).margin(EdgeInsets.symmetric(horizontal: 15)).shadowSm.roundedSM.make(),


                Divider(),
                10.heightBox,
                "Ordered Products".text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                10.heightBox,
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(data['orders'].length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                          title1: data['orders'][index]['title'],
                          title2: data['orders'][index]['total_price'].toString().numCurrency,
                          d1: "${data['orders'][index]['quantity']}x",
                          d2: "Refundable"
                        ),
                        VxBox().color(Color(data['orders'][index]['color'])).size(20, 20).margin(EdgeInsets.symmetric(horizontal: 10)).roundedFull.make(),
                        Divider()
                      ],
                    );
                  }).toList(),
                ).box.padding(EdgeInsets.symmetric(horizontal: 10,vertical: 10)).color(lightGrey).margin(EdgeInsets.symmetric(horizontal: 15)).shadowSm.roundedSM.make(),


                //subtotal section
                20.heightBox,



              ],
            )
          ],
        ),
      ),
    );
  }
}
