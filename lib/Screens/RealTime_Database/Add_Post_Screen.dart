import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorial_project/Utills/Utills.dart';
import 'package:firebase_tutorial_project/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final addPostController=TextEditingController();
  final titlePostController=TextEditingController();
  bool loading=false;
  final databaseRef=FirebaseDatabase.instance.ref("Node");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseRef.onValue.listen((event) {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
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
              controller: addPostController,
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

              String id=DateTime.now().millisecondsSinceEpoch.toString();

              databaseRef.child(id).set({
                "Description" :addPostController.text.toString(),
                "title" : titlePostController.text.toString(),
                "id" : id,

              }).then((value){
                setState(() {
                  loading=false;
                });
                Utills().toastMessage("Data Inserted!");
              }).onError((error, stackTrace) {
                setState(() {
                  loading=false;
                });
                Utills().toastMessage(error.toString());
              });

            }),
          ],
        ),
      ),
    );
  }
}
