
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial_project/Screens/Auth/Verified_Code_Screen.dart';
import 'package:firebase_tutorial_project/Utills/Utills.dart';
import 'package:firebase_tutorial_project/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumberController=TextEditingController();
  bool loading=false;

  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login with Phone Number"),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            SizedBox(height: 80,),

            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "+92 341 3468281"
              ),
            ),
            SizedBox(height: 80,),

            RoundButton(
              loading: loading,
                title:"Login",onTab: (){
                  setState(() {
                    loading=true;
                  });
              auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text.toString(),
                  verificationCompleted: (_){
                  setState(() {
                    loading=false;
                  });
                  },
                  verificationFailed: (e){
                    setState(() {
                      loading=false;
                    });
                    Utills().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token){
                    setState(() {
                      loading=false;
                    });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifiedCodeScreen(verificationId:verificationId)));
                  },
                  codeAutoRetrievalTimeout: (e){
                    setState(() {
                      loading=false;
                    });
                    Utills().toastMessage(e.toString());
                  });
            }),

          ],
        ),
      ),
    );
  }
}
