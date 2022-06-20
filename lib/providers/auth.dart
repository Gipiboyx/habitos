//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  String _userLastName = '';
  String _userID = '';

  AuthProvider() {
    _isLoading = false;
    _isLogin = true;
    _userEmail = '';
    _userName = '';
    _userPassword = '';
    _userLastName = '';
    _userID = '';
  }

  get isLoading => this._isLoading;

  set isLoading(value) {
    this._isLoading = value;
    notifyListeners();
  }

  get isLogin => this._isLogin;

  set isLogin(value) {
    this._isLogin = value;
    notifyListeners();
  }

  get userEmail => this._userEmail;

  set userEmail(value) {
    this._userEmail = value;
    notifyListeners();
  }

  get userName => this._userName;

  set userName(value) {
    this._userName = value;
    notifyListeners();
  }

  get userPassword => this._userPassword;

  set userPassword(value) {
    this._userPassword = value;
    notifyListeners();
  }

  get userLastName => this._userLastName;

  set userLastName(value) {
    this._userLastName = value;
    notifyListeners();
  }

  get userID => this._userID;

  set userID(value) {
    this._userID = value;
    notifyListeners();
  }

  Future<bool> login() async {
    try {
      isLoading = true;
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userEmail, password: userPassword);
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: userEmail, password: userPassword);
      }

      isLoading = false;
      return true;
    } catch (err) {
      print(err);
      isLoading = false;
      return false;
    }
  }

  void logout() async {
    FirebaseAuth.instance.signOut();
  }
}
