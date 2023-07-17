import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/chats_controller.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/chat_screen/chat_components/sender_bubble.dart';
import 'package:e_mart/widgets_common/custom_textfield.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});


  @override
  Widget build(BuildContext context) {
    
    var chatController =  Get.put(ChatsController());

    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: chatController.sellerName.toString().text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Column(
        children: [
          //chat portion
         Obx(()=> chatController.isLoading.value? Center(child: loadingIndicator(),)
         :Expanded(
             child: StreamBuilder(
               stream: FirestoreServices.getChatMessages(chatController.chatDocId.toString()),
               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                 if(!snapshot.hasData){
                   return Center(child: loadingIndicator(),);
                 }
                 else if(snapshot.data!.docs.isEmpty){
                   return Center(child: "Send a message...".text.make(),);
                 }
                 else {
                   return ListView(
                     children: snapshot.data!.docs.mapIndexed((currentValue, index) {

                       var data = snapshot.data!.docs[index];
                       //wrapping wiht align so that seller msg show on left side and user msg on right side
                       return Align(
                         alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                           child: senderBubble(data)
                       );
                     }).toList()
                   );
                 }
               },
             ),
           ),
         ),


          //send message section
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                controller: chatController.msgController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: textfieldGrey)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey)
                  ),
                  hintText: "Type a message"
                ),
              ).expand(),


              //send message portion
              IconButton(onPressed: (){
                chatController.sendMsg(chatController.msgController.text);
                chatController.msgController.clear();         //so that we dont have to erase again again
              }, icon: Icon(Icons.send,color: redColor,))
            ],
          ).box.height(80).make()
        ],
      ).box.padding(EdgeInsets.all(12)).make(),
    );
  }
}

