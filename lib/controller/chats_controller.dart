import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/home_controller.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController{

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);

  var sellerName = Get.arguments[0];       //friendName = sellerName
  var sellerId  = Get.arguments[1];        //sellerID = friend Id

  var senderName  = Get.find<HomeController>().username;         //senderName == senderName
  var senderId  = currentUser!.uid;                             // senderId = current id

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;

  //function to get id of chats
  getChatId()async{
    isLoading(true);
    await chats.where('users',isEqualTo: {
      //checking so may values therfore passing map -->limit ==1 means only such type of 1 elemnet is aviailable
      sellerId:null,
      senderId:null,
    }).limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){
        chatDocId = snapshot.docs.single.id;       //-> storing id of chats in chatDocId
      }
      else{
        //such chats are empty so make one by adding in database
        chats.add({
          'created_on':null,
          'last_msg':'',
          'users':{sellerId:null,senderId:null},
          'toId':'',
          'fromId':'',
          'seller_name':sellerName,
          'sender_name':senderName,
        }).then((value) {
          chatDocId = value.id;
        });
      }
    });
    isLoading(false);
  }


  //if msg given is not empty and store that msg on firebase using chatDoc id since ussi id me sare msg hoge
  sendMsg(String msg){
    if(msg.trim().isNotEmpty){
      chats.doc(chatDocId).update({
        'created_on':FieldValue.serverTimestamp(),  //server time will store here
        'last_msg':msg,
        'users':{sellerId:null,senderId:null},
        'toId':sellerId,
        'fromId':senderId,
        'seller_name':sellerName,
        'sender_name':senderName,
      });

      //now after chats id created we make one more collection inside it called messages where all msg between seller and sender will store
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on':FieldValue.serverTimestamp(),
        'msg':msg,
        'uid':senderId
      });
    }
  }



}