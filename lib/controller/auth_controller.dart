import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  var isloading = false.obs;

  //login method -->this method will retunr user credientials
  Future<UserCredential?> loginMethod({context,useremail,userpassword}) async{
    //async will make this function asynchronous
    //and fyture will return UserCredential;   ---> whatever data type we pass in future<> it will return this
    UserCredential? userCredential;
    //try and catch code
    try{
      //the actual code you want to run
      //here useremail,userpassword we get from screen using controller
      // await----> wait till this will not excute completely auth.signInWithEmailAndPassword(email: useremail, password: userpassword);
      userCredential = await auth.signInWithEmailAndPassword(email: useremail, password: userpassword);
  }on FirebaseAuthException catch(e){
      //code runs if some error comes in try code
      //we will show a toast
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }



  //signup method
  Future<UserCredential?> signupMethod({useremail,userpassword,context}) async{
    UserCredential? userCredential;
    try{
      userCredential =  await auth.createUserWithEmailAndPassword(email: useremail, password: userpassword);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }


  //storing data on firebase store
  // here one collection is made on firestore of name userCollection where with particular userid we set some things relted to that user
  storeUserData({name,password,email})async{
    DocumentReference store = await firestore.collection(userCollection).doc(currentUser!.uid);  ////or we can wrire -->FirebaseFirestore.instance.collection("users")
    store.set({
      'name' : name,
      'password' : password,
      'email' : email,
      'imageUrl' : '',
      'id' : currentUser!.uid,
      'cart_count': "00",
      'wishlist_count': "00",
      'order_count': "00",

    });
  }

  //signout method
  signoutMethod(context)async{
    try{
      await auth.signOut();
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }

}