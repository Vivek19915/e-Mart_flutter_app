import 'package:e_mart/consts/consts.dart';

class FirestoreServices {

  //get users data from firestore
  static getUser(uid){
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
  }
}