import 'package:e_mart/cart_screen/payment_method.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/cart_controller.dart';
import 'package:e_mart/widgets_common/custom_textfield.dart';
import 'package:e_mart/widgets_common/our_button.dart';
import 'package:get/get.dart';
class ShippingDetailsScreen extends StatelessWidget {
  const ShippingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shipping Details".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: ourButton(
        title: "Continue",
        textcolor: whiteColor,
        buttoncolor: redColor,
        onpress: (){
          // if(cartController.addressController.text.length == 0 || cartController.stateController.text.length == 0 ||cartController.postal_code_Controller.text.length == 0 || cartController.cityController.text.length == 0 || cartController.phoneController.text.length == 0 ){
          //   VxToast.show(context, msg: "Please fill all fields");
          // }
          // else{
            Get.to(()=>PaymentMethods());
          // }
        }
      ).box.height(50).make(),

      body: Column(
        children: [
          customTextFiled(hint: "Address" , b: false , title: "Address",controller: cartController.addressController),
          customTextFiled(hint: "City" , b: false , title: "City",controller: cartController.cityController),
          customTextFiled(hint: "State" , b: false , title: "State",controller: cartController.stateController),
          customTextFiled(hint: "Postal Code" , b: false , title: "Postal Code",controller: cartController.postal_code_Controller),
          customTextFiled(hint: "Phone" , b: false , title: "Phone",controller: cartController.phoneController),
        ],
      ).box.padding(EdgeInsets.all(16)).make(),
    );
  }
}
