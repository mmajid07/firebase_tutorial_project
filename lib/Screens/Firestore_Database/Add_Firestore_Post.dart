import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial_project/Utills/Utills.dart';
import 'package:firebase_tutorial_project/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';

class FirestorePostScreen extends StatefulWidget {
  const FirestorePostScreen({super.key});

  @override
  State<FirestorePostScreen> createState() => _FirestorePostScreenState();
}

class _FirestorePostScreenState extends State<FirestorePostScreen> {
  final desPostController=TextEditingController();
  final titlePostController=TextEditingController();
  bool loading=false;
  final firestoreData=FirebaseFirestore.instance.collection("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Firestore Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextField(
              controller: titlePostController,

              decoration: InputDecoration(
                  hintText: "Post title",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              controller: desPostController,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: "What's in your mind?",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(
                loading: loading,
                title: "Add Post", onTab: ( ){
              setState(() {
                loading=true;
              });

              String id= DateTime.now().millisecondsSinceEpoch.toString();

              firestoreData.doc(id).set({
                "id" :id,
                "description" : desPostController.text,
                "title": titlePostController.text,
              }).then((value) {
                setState(() {
                  loading=false;
                });
                Utills().toastMessage("Data Added");
              }).onError((error, stackTrace){
                setState(() {
                  loading=false;
                });
                Utills().toastMessage(error.toString());
              });
              Navigator.pop(context);



            }),
          ],
        ),
      ),
    );
  }
}
