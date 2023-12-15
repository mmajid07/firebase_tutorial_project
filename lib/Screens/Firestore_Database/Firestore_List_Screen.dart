import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial_project/Screens/Auth/Login_Screen.dart';
import 'package:firebase_tutorial_project/Utills/Utills.dart';
import 'package:flutter/material.dart';


import 'Add_Firestore_Post.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {

  final updateController=TextEditingController();
  final desupdateController=TextEditingController();

  final auth= FirebaseAuth.instance;

  bool loading=false;
  final firestoreData=FirebaseFirestore.instance.collection("user").snapshots();

  final ref=FirebaseFirestore.instance.collection("user");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Firestore Screen'),
        actions: [
          IconButton(onPressed: ( ){
            auth.signOut().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }).onError((error, stackTrace) {
              Utills().toastMessage(error.toString());
            });
          }, icon: Icon(Icons.logout)),
          SizedBox(width: 10,),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),

          StreamBuilder <QuerySnapshot>(
              stream: firestoreData,
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        if(snapshot.hasError){
                          return Text("Some Error");
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data!.docs[index]["title"].toString()),
                                  Text(snapshot.data!.docs[index]["description"].toString()),

                                ],
                              ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    IconButton(onPressed: ( ){

                                      final id=snapshot.data!.docs[index]["id"].toString();
                                      final title=snapshot.data!.docs[index]["title"].toString();
                                      final description=snapshot.data!.docs[index]["description"].toString();
                                      showMyDialog(title,description,id );

                                    }, icon: Icon(Icons.edit)),

                                    IconButton(onPressed: ( ){

                                      final id=snapshot.data!.docs[index]["id"].toString();
                                      ref.doc(id).delete();

                                    }, icon: Icon(Icons.delete)),
                                  ],
                                ),

                            ],
                          ),
                        );
                      }),
                );
              }),




        ],
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: ( ){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FirestorePostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String description, String id)async{
    updateController.text=title;
    desupdateController.text=description;
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Update"),
            content:Container(
              height: 180,
              child: Column(
                children: [
                  TextField(
                    controller: updateController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Update....."
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextField(
                    controller: desupdateController,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Update....."
                    ),
                  ),
                ],
              ),
            ),
            actions: [

              TextButton(onPressed: ( ){
                Navigator.pop(context);
              }, child: Text("Cancel")),

              TextButton(
                  onPressed: ( ){
                    ref.doc(id).update({
                      "title": updateController.text,
                      "description" : desupdateController.text,
                    }).then((value) {
                      Utills().toastMessage("Data Updated");
                    }).onError((error, stackTrace) {
                      Utills().toastMessage(error.toString());
                    });
                    Navigator.pop(context);
                  }, child: Text("Update")),
            ],
          );
        });
  }
}
