import 'package:e_mart/cart_screen/cart_screen.dart';
import 'package:e_mart/category_screen/category_screen.dart';
import 'package:e_mart/controller/home_controller.dart';
import 'package:e_mart/profile_screen/profile_screen.dart';
import 'package:e_mart/views/home_screen/home_screen.dart';
import 'package:e_mart/widgets_common/exit_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../controller/product_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    //init home controller
    var controller = Get.put(HomeController());
    var productController = Get.put(ProductController());

    //creating list of item for bottom navabr
    var navbarItem  = [
      // BottomNavigationBarItem takes 2 input 1 - icon 2 - icon label
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26,),label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26,),label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26,),label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,),label: account),
    ];

    //making one more list fro each navbar body
    var navBody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    // The Obx widget is particularly useful when you have a small portion of the UI that needs to be updated when a specific observable variable changes.
    // thats why we are using obx when we switching bottomnavbar

    // WillPopScope dalog box for exit app

    return WillPopScope(
      onWillPop: ()async{
        showDialog(
          barrierDismissible: false,         //so that dialog will not close without any action
            context: context,
            builder: (context)=>exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(()=> Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(()=>
            BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            items: navbarItem,                              //passing navbar list because we have to pass list here
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(fontFamily: semibold,color: redColor),
            onTap: (value){
              // print(value); ----> value == index of that item  ------ and then that value get store in controller
              // which is passed to current index and then that item go highlited
              controller.currentNavIndex.value = value;    //for highlighting jisko click karege
            },
          ),
        )
      ),
    );
  }
}
