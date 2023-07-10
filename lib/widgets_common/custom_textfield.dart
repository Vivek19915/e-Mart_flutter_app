import 'package:e_mart/consts/consts.dart';

Widget customTextFiled({String ? title , String ? hint  ,controller, bool b=false }){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).size(16).semiBold.make(),
      TextFormField(
        obscureText: b,
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(fontFamily: semibold,color: textfieldGrey),
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: redColor)),
        ),
      ),
      10.heightBox,
    ],
  );
}