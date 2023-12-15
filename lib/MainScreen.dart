import 'package:firebase_tutorial_project/Screens/Firestore_Database/Firestore_List_Screen.dart';
import 'package:firebase_tutorial_project/Upload_Image/Upload_Image_Screen.dart';
import 'package:firebase_tutorial_project/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';

import 'Screens/RealTime_Database/Post_Screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundButton(title: "RealTime Database", onTab: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
            }),

            SizedBox(height: 15,),

            RoundButton(title: "FireStore Database", onTab: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FirestoreScreen()));
            }),

            SizedBox(height: 15,),
            RoundButton(title: "UploadFile Database", onTab: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadImageScreen()));
            }),
          ],
        ),
      ),
    );
  }
}
