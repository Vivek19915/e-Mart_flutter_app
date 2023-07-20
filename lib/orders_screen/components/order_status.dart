import 'package:e_mart/consts/consts.dart';
import 'package:get/get.dart';

Widget orderStatus({icon , color, title , bool showDone = false}){
  return ListTile(
    leading: Icon(icon,color: color,).box.border(color: color).roundedSM.padding(EdgeInsets.all(4)).make(),
    trailing: SizedBox(
      height: 100,
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          title.toString().text.color(darkFontGrey).make(),
          showDone ? Icon(icon,color: color,)
              : Container(),
        ],
      ),
    ),
  );
}
