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
}