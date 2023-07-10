import 'package:e_mart/consts/consts.dart';

Widget ourButton({String ? title , onpress , textcolor , buttoncolor}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttoncolor,
        padding: EdgeInsets.all(12),
      ),
      onPressed: onpress,
      child: title!.text.semiBold.color(textcolor).make());
}