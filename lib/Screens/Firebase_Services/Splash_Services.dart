import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial_project/Screens/Auth/Login_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../MainScreen.dart';




class SplashServices{

  void isLogin(BuildContext context){
    FirebaseAuth auth=FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user!=null){
      Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
      });
    }else{
      Timer(Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen())));
    }

  }
}