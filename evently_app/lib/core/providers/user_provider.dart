import 'package:evently_v2/config/firebase/firebase_auth.dart';
import 'package:evently_v2/core/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? firebaseUser ;
  UserModel? userModel ;

  void initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      userModel = await FirebaseAuthentication.getCurrentUser();
      notifyListeners();
    }
  }
  clearData(){
    firebaseUser = null;
    userModel = null;
    notifyListeners();

  }
}