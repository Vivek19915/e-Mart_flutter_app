

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/chat_screen/chat_screen.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Your Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),

      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData == false){
            return Center(child: loadingIndicator(),);
          }
          else if(snapshot.data!.docs.isEmpty){
            return "No messages Yet!".text.color(darkFontGrey).makeCentered();
          }
          else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                          itemBuilder: (BuildContext context , int index){
                          return Card(
                            child: ListTile(
                              onTap: (){
                                Get.to(()=>ChatScreen(),arguments: [data[index]['sender_name'],data[index]['toId']]);
                              },
                              leading: CircleAvatar(
                                child: Icon(Icons.person,color: whiteColor,),
                                backgroundColor: redColor,
                              ),
                              title: data[index]['seller_name'].toString().text.fontFamily(semibold).color(darkFontGrey).make(),
                              subtitle: data[index]['last_msg'].toString().text.color(darkFontGrey).make()
                            ),
                          );
                          }
                      ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
