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

  var products = [];

  var placingOrder = false.obs;

  calulate(data){
    total_price.value=0;
    for(var i = 0 ; i<data.length ; i++ ){
      total_price = total_price + int.parse(data[i]['total_price'].toString());
    }
  }

  changePaymentIndex(index){
    paymentIndex.value = index;
  }


  placeMyOrder({required orderPaymentMethod ,required totalAmount})async{

    placingOrder(true);
    await getProductsDetails();

    await firestore.collection(ordersCollection).doc().set({
      //this is mapping
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
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),      //products list contain all info about product order by user
    });
    placingOrder(false);
  }


//this function will get details of each product in from of map and store it in list
  getProductsDetails(){
    products.clear();
    for(int i=0 ;  i < productSnapshot.length; i++){
      products.add({
        //this is mapping and storing in list
        'color':productSnapshot[i]['color'],
        'img':productSnapshot[i]['img'],
        'vendor_id':productSnapshot[i]['vendor_id'],
        'total_price':productSnapshot[i]['total_price'],
        'quantity':productSnapshot[i]['quantity'],
        'title':productSnapshot[i]['title'],
      });
    }
    print(products);
  }



  //as orders got placed then products in cart are of no value -->therefore we clear cart after order placed
  clearCart(){
    for(int i = 0 ; i <productSnapshot.length ; i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }




}