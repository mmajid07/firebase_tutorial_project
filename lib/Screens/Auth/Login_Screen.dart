import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial_project/Screens/Auth/Forgot_Password.dart';
import 'package:firebase_tutorial_project/Screens/Auth/SignUp_Screen.dart';
import 'package:firebase_tutorial_project/Utills/Utills.dart';
import 'package:firebase_tutorial_project/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../RealTime_Database/Post_Screen.dart';
import 'Login_with__PhoneNumber.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController= TextEditingController();
  final passwordController= TextEditingController();
  final _formkey = GlobalKey <FormState>();
  bool loading=false;

FirebaseAuth _auth= FirebaseAuth.instance;

void login(){
  setState(() {
    loading=true;
  });
  _auth.signInWithEmailAndPassword(
      email: emailController.text.toString(), 
      password: passwordController.text.toString()).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
        Utills().toastMessage(value.user!.email.toString());
        setState(() {
          loading=false;
        });
  }).onError((error, stackTrace){
    debugPrint("Error: "+error.toString());
    Utills().toastMessage(error.toString());
    setState(() {
      loading=false;
    });
  });
  
}

  bool securePassword=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text("Login"))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: 50,
                ),

                Form(
                  key: _formkey,
                  child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        // Check if this field is empty
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }

                         if(!RegExp(r'\S+@\S+\.\S+').hasMatch(value)){
                           return "Please enter a valid email address";
                         }

                        // the email is valid
                        return null;
                      },

                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.alternate_email),
                        hintText: "Email"
                      ),

                    ),
                    TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter Email";
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText:securePassword ? true:false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Icon(securePassword? Icons.visibility_off : Icons.visibility ),
                        hintText: "Password"
                      ),
                      onTap:( ){
                        setState(() {
                          securePassword=!securePassword;
                        });
                      },

                    ),
                  ],
                )),

                SizedBox(
                  height: 50,
                ),

                RoundButton(
                  loading: loading,
                  onTab: (){
                    if(_formkey.currentState!.validate());
                    login();

                    

                  },
                  title: "Login"),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(onPressed: ( ){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                    }, child: Text("Forgot Password")),
                  ),
                ),
                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("If you don't have Account? "),
                    TextButton(onPressed: ( ){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                    }, child: Text("SignUp")),

                  ],
                ),
                SizedBox(height: 40,),

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhoneNumber()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )
                    ),
                    child: Center(child: Text("Login with Phone Number")),
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}