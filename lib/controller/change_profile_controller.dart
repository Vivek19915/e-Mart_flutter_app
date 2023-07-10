import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController{

  var profilrIMgPath = ''.obs;

  //textfields
  var nameController = TextEditingController();
  var newpassController = TextEditingController();
  var oldpassController = TextEditingController();

  // so that we can use it as global for this class
  var profileImageLink = '';

  var isloading = false.obs;


  //change profile image method
  changeImage(context) async{
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
      if(img==null)return;
      else profilrIMgPath.value = img.path;
    }
    on PlatformException catch (e){
      VxToast.show(context, msg: e.toString());
    }
  }


  //update profile image method
  uploadProfileImage() async {
    var filename  = basename(profilrIMgPath.value);
    var destination  = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profilrIMgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  //update on firebase
  updateProfile({name,password,imgUrl}) async{
    var store  = firestore.collection(userCollection).doc(currentUser!.uid);
     await store.set({
      'name' : name,
      'password' : password,
      'imageUrl' : imgUrl,
    },SetOptions(merge: true));
     isloading(false);
  }


  //to change old suthentication password to new pasword
  changeAuthPassword({email,oldpass,newpass})async{
    final cred = EmailAuthProvider.credential(email: email, password: oldpass);
    await currentUser!.reauthenticateWithCredential(cred)         //phirse user ko login karke pass change kar dega
    .then((value){
      currentUser!.updatePassword(newpass);
    }).catchError((error){debugPrint(error.toString());});       //catch error if some error occur then print it
  }



}