import 'package:get/get.dart';

class CartController extends GetxController{

  var total_price =  0.obs;

  calulate(data){
    total_price.value=0;
    for(var i = 0 ; i<data.length ; i++ ){
      total_price = total_price + int.parse(data[i]['total_price'].toString());
    }


  }
}