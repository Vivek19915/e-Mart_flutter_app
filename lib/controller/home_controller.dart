import 'package:e_mart/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit --> as soon as homecontroller created we get our user name
    getUserName();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var username = "";

  //to get user name according to current user id
  getUserName() async {
   var name =  await firestore.collection(userCollection).where('id',isEqualTo: currentUser!.uid).get()
    .then((value) {
      //whatever we get willl store in value variable
     if(value.docs.isNotEmpty){
       return value.docs.single['name'];
     }
    });
   username = name;
   debugPrint(username);
  }
}