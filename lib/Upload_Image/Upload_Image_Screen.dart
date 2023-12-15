
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_tutorial_project/Utills/Utills.dart';
import 'package:firebase_tutorial_project/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  bool loading =false;

   File? _image;
   final picker=ImagePicker();

    firebase_storage.FirebaseStorage storage= firebase_storage.FirebaseStorage.instance;
    DatabaseReference databaseReference=FirebaseDatabase.instance.ref("Node");

   Future getGalleryImage() async{
     final pickedFile= await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
     setState(() {
       if(pickedFile!=null){
         _image=File(pickedFile.path);
       }else{
         print("Image cannot Picked");
       }
     });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Upload Image")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Center(
              child: InkWell(
                onTap: (){
                  getGalleryImage();

                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  child:_image !=null ? Image.file(_image!.absolute) :Icon(Icons.image),
                ),
              ),
            ),
            SizedBox(height: 40,),

            RoundButton(title: "Upload Image",loading: loading, onTab: ( )async{

              firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/folderName/'+DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask=ref.putFile(_image!.absolute);
              await Future.value(uploadTask);

              var newUrl=await ref.getDownloadURL();

              setState(() {
                loading=true;
              });
              databaseReference.child("1").set({
                "title": "Image",
                "description": newUrl.toString(),
              }).then((value) {
                setState(() {
                  loading=false;
                });
                Utills().toastMessage("Uploaded");
              }
              ).onError((error, stackTrace) {
                setState(() {
                  loading=false;
                });
                Utills().toastMessage(error.toString());
              });
            })
          ],
        ),
      ),
    );
  }
}
