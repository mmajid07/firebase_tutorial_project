
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial_project/Utills/Utills.dart';
import 'package:flutter/material.dart';

import '../RealTime_Database/Post_Screen.dart';
import '../../Widgets/RoundButton.dart';

class VerifiedCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifiedCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifiedCodeScreen> createState() => _VerifiedCodeScreenState();
}

class _VerifiedCodeScreenState extends State<VerifiedCodeScreen> {
  final verifyNumberController=TextEditingController();
  bool loading=false;

  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            SizedBox(height: 80,),

            TextFormField(
              controller: verifyNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "6 digit code"
              ),
            ),
            SizedBox(height: 80,),

            RoundButton(
                loading: loading,
                title:"Verify",onTab: ()async{
                  setState(() {
                    loading=true;
                  });
                  final credential=PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verifyNumberController.text.toString());
              try{

                 await auth.signInWithCredential(credential);

                 Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
              }catch (e){
                setState(() {
                  loading=false;
                });
                Utills().toastMessage(e.toString());

              }

            }),

          ],
        ),
      ),
    );
  }
}
