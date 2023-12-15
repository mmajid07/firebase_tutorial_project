

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utills{
   void toastMessage(String message){
     Fluttertoast.showToast(
         msg: message,
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       backgroundColor: Colors.black,
       textColor: Colors.white,
       fontSize: 16,

     );
   }
}