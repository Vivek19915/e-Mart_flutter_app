import 'package:e_mart/consts/consts.dart';

// creating Widget
Widget applogoWidget(){
  //instead of returning containor you can use velocity x return Container();
  // return Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: Container(
  //     color: Colors.white,
  //     child: Image.asset(icAppLogo,width: 77,height: 77,),
  //   ),
  // );
  
  // using velocity x
  return Image.asset(icAppLogo).box.white.rounded.size(77, 77).padding(EdgeInsets.all(8.0)).make();
}