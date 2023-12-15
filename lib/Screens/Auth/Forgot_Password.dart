import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial_project/Utills/Utills.dart';
import 'package:firebase_tutorial_project/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
    ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController=TextEditingController();

  bool loading =false;

  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                hintText: 'Please enter email'
              ),
            ),
            SizedBox(height: 40,),

            RoundButton(
                loading: loading,
                title: "Forgot Password", onTab: (){

              setState(() {
                loading=true;
              });
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                setState(() {
                  loading=false;
                });
                Utills().toastMessage("Email Successfully send");
              }).onError((error, stackTrace) {
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
