import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../consts/consts.dart';
import 'home_controller.dart';

class CartController extends GetxController{

  var total_price =  0.obs;


  //text controller for shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postal_code_Controller = TextEditingController();
  var phoneController = TextEditingController();

  //choosen payment index
  var paymentIndex = 0.obs;

  late dynamic productSnapshot;

  calulate(data){
    total_price.value=0;
    for(var i = 0 ; i<data.length ; i++ ){
      total_price = total_price + int.parse(data[i]['total_price'].toString());
    }
  }

  changePaymentIndex(index){
    paymentIndex.value = index;
  }


  placeMyOrder({orderPaymentMethod , totalAmount})async{
    await firestore.collection(ordersCollection).doc().set({
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get. find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController. text,
      'order_by_state': stateController. text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController. text,
      'order_by_postalcode': postal_code_Controller. text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'total_amount': totalAmount,

    });
  }

}