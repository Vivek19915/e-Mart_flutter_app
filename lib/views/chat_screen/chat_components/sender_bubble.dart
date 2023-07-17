import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data){

  var t =  data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Container(
    decoration: BoxDecoration(
      //color and border changing according to seller and user
      color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
      borderRadius:data['uid'] == currentUser!.uid ? BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),bottomLeft: Radius.circular(10))
      :BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
    ),
    child: Column(
      //direction of message changing according to seller and user
      crossAxisAlignment: data['uid'] == currentUser!.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
      children: [
        data['msg'].toString().text.white.size(16).make(),
        10.heightBox,
        time.toString().text.white.size(12).make(),
      ],
    ).box.padding(EdgeInsets.all(8)).make(),
  ).box.margin(EdgeInsets.only(bottom: 8)).make();
}