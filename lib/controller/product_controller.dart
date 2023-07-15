import 'package:e_mart/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

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
}