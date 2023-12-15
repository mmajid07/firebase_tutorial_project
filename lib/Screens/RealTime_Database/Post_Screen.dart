import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tutorial_project/Screens/Auth/Login_Screen.dart';
import 'package:firebase_tutorial_project/Utills/Utills.dart';
import 'package:flutter/material.dart';
import 'Add_Post_Screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final searchController=TextEditingController();
  final updateController=TextEditingController();
  final desupdateController=TextEditingController();

  final auth= FirebaseAuth.instance;

  final ref=FirebaseDatabase.instance.ref("Node");

  bool loading=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Post Screen'),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(),
              ),
              onChanged: ( value){
                setState(() {

                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context,snapshot,animation,index){

                  final tit=snapshot.child("title").value.toString();
                  final Des=snapshot.child("Description").value.toString();
                  final id = snapshot.child("id").value.toString();

                  if(searchController.text.isEmpty){
                    return ListTile(

                      title: Text(snapshot.child("title").value.toString()),
                      subtitle: Text(snapshot.child("Description").value.toString()),
                      trailing:  PopupMenuButton(
                        itemBuilder: (context){
                          return [
                            PopupMenuItem(
                              value: 1,
                                child: ListTile(
                                  title: Text("Edit"),
                                  trailing: Icon(Icons.edit),
                                ),
                            onTap: (){
                              showMyDialog(tit, Des, id);
                            },),
                            PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  title: Text("Delete"),
                                  trailing: Icon(Icons.delete),
                                ),
                            onTap: (){
                                  ref.child(id).remove();
                            },
                            )
                          ];
                        },
                      )
                    );
                  }else if(tit.toLowerCase().contains(searchController.text.toLowerCase())){
                    return Container(
                      child: ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(snapshot.child("Description").value.toString()),
                      ),
                    );
                  }else{
                    return Container();
                  }

                }),
          ),


        ],
      ),
      floatingActionButton: FloatingActionButton(

          onPressed: ( ){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostScreen()));
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
                ref.child(id).update({
                  "title" : updateController.text,
                  "Description" :desupdateController.text,
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


// Expanded(
//     child: StreamBuilder(
//       stream: ref.onValue,
//       builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
//         if(!snapshot.hasData){
//           return Center(child: CircularProgressIndicator());
//         }else{
//           return ListView.builder(
//             itemCount: snapshot.data!.snapshot.children.length,
//               itemBuilder: (context , index){
//               Map<dynamic, dynamic> maplist=snapshot.data!.snapshot.value as dynamic;
//
//               List<dynamic> dataList=[];
//               dataList.clear();
//               dataList=maplist.values.toList();
//                 if(!snapshot.hasData){
//                   return Center(child: CircularProgressIndicator());
//                 }else{
//                   return ListTile(
//                     title: Text(dataList[index]["title"]),
//                     subtitle: Text(dataList[index]["Description"]),
//                   );
//                 }
//               });
//         }
//       },
//     )),
