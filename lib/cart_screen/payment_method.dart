import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/consts/list.dart';
import 'package:e_mart/controller/cart_controller.dart';
import 'package:e_mart/views/home_screen/home.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

import '../widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {

    var cartController = Get.find<CartController>();

    return Obx(
      ()=> Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Choose Payments Methods".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),

        bottomNavigationBar: SizedBox(
          height: 60,
          child: cartController.placingOrder.value ? Center(child: loadingIndicator(),)
          :ourButton(
              title: "Place Order",
              textcolor: whiteColor,
              buttoncolor: redColor,
              onpress: ()async{

                await cartController.placeMyOrder(
                      orderPaymentMethod: paymentMethodList[cartController.paymentIndex.value],
                      totalAmount: cartController.total_price.value
                );

                //after placing order clear the cart
                await cartController.clearCart();
                VxToast.show(context, msg: "Order Placed Succesfully");

                Get.offAll(Home());
;
              }
          ).box.height(50).make(),
        ),


        body: Obx(
            ()=> Column(
            children: List.generate(paymentMethodList.length, (index) {
              return GestureDetector(
                onTap: (){cartController.changePaymentIndex(index);},
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [

                    //image -->
                    Image.asset(paymentMethodImages[index],width: double.infinity,height: 140,fit: BoxFit.cover,)
                    .box.margin(EdgeInsets.only(bottom:10 )).roundedSM.clip(Clip.antiAlias).
                    border(color: cartController.paymentIndex.value == index ? redColor : Colors.transparent,width: 4).make(),

                    //alignment of name of image
                    Align(
                        alignment: Alignment.topLeft,
                        child: paymentMethodList[index].text.white.bold.size(16).make()
                            .box.padding(EdgeInsets.only(left: 7,top: 3)).make()),


                    //checkbox ----->
                    cartController.paymentIndex.value == index ? Transform.scale(      //to scale the size of checkbox
                      scale: 1.3,
                      child: Checkbox(
                          activeColor: Colors.green,
                          value: true,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          onChanged: (value){},
                      ),
                    )
                    : Container()
                  ],
                ),
              );
            }),
          ).box.padding(EdgeInsets.all(12)).make(),
        ),



      ),
    );
  }
}
