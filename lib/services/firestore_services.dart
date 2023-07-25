import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';

class FirestoreServices {

  //get users data from firestore
  static getUser(uid){
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();   //here where is used for filtering --> like sql where
  }


  //get products details according to category 
  static getProduct(category){
    return firestore.collection(productsCollection).where('p_category',isEqualTo:category).snapshots();
  }


  //get cart --> it willl get cart using user->id
  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }

  //to delete any document using document id
  static deleteDocument(docID){
    return firestore.collection(cartCollection).doc(docID).delete();
  }


  //get all chat messages
   static getChatMessages(docId) {
    //print msg by sorting on created on filed
     return FirebaseFirestore.instance.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on',descending: false).snapshots();
  }


  //get all oreders of user
  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).snapshots();
  }


  //get wishlist orders according to each user
  static getWishlist(){
    return firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
    //therefore here it will search our id in p_wishlist of each product and those product have out id it will save that product info to snapshot
  }


  //get all message
  static getAllMessages(){
    return firestore.collection(chatsCollection).where('fromId',isEqualTo: currentUser!.uid).snapshots();
  }



  //remove from wishlist of user
  static removeFromWishlist(docID){
    return firestore.collection(productsCollection).doc(docID).set({
      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
    },SetOptions(merge: true));
  }



  static getCounts() async {
    var res = await Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }



  static getAllProducts(){
    return firestore.collection(productsCollection).snapshots();
  }



  //get featured products -->
  static getFeaturedProduct(){
    return firestore.collection(productsCollection).where('p_featured',isEqualTo: true).snapshots();
  }
}