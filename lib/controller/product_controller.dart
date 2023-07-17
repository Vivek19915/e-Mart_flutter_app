import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  var quantity = 0.obs;                      //to store quantity of product chose by user
  var colorChosenIndex = 0.obs;             //color selected by user

  var subcat = [];
  //function to get subCategories from json model
  getSubCategories({title}) async {
    subcat.clear();       //so that already subcat will get erased
    //json data will store in jsondata --> and this we will pass to our category model
    var jsondata = await rootBundle.loadString("lib/services/category_model.json");
    var decoded_data = categoryModelFromJson(jsondata);
    //filtring subcat on the basis of tile given
    var s = decoded_data.categories.where((element) => element.name == title).toList();

    // ..adding subcategories of tile in subcat list
    for(var i in s[0].subcategories){
      subcat.add(i);
    }
  }


  increaseQunatity( String maxquantity){
    int a = int.parse(maxquantity);
    if(a>quantity.value){
      quantity.value++;
    }
  }

  decreaseQunatity(){
    if(quantity.value>0){
      quantity.value--;
    }
  }


  addToCart({title,img,sellername,color,quantity,total_price,context})async{
    await firestore.collection(cartCollection).doc().set({         //as here we dont sepcify current suer id in doc then why whnever add to cart is called an new id is map on databse and new instance will create while if we provide doc id then it will update each time the values
      'title' : title,
      'img': img,
      'seller_name' : sellername,
      'color': color,
      'quantity': quantity,
      'total_price': total_price.toString(),
      'added_by': currentUser!.uid,
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }


  resetValues(){
    quantity.value = 0;
    colorChosenIndex.value = 0;
  }

}