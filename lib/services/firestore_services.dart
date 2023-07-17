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
}