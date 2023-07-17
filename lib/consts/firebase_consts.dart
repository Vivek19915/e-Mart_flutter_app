import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;                       //used where authentication required
FirebaseFirestore firestore = FirebaseFirestore.instance;             // used to get and  update data on firebase
User? currentUser = auth.currentUser;                                   //?--NULABLE VARIABLE MEANS NULL VALUE NHI HOGI AND  jo bhi current user hoga uska all data we get from current user


//collections names that are used in database like users and drivers when you use in fire storage.instance.collection(userCollection)
const userCollection = "users";
const productsCollection = "products";
const cartCollection = "cart";