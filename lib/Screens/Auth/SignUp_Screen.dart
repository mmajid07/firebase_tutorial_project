import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial_project/Screens/Auth/Login_Screen.dart';
import 'package:firebase_tutorial_project/Utills/Utills.dart';
import 'package:firebase_tutorial_project/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final emailController= TextEditingController();
  final passwordController= TextEditingController();
  final _formkey = GlobalKey <FormState>();

  bool loading=false;

  void signUp(){
    setState(() {
      loading=true;
    });
    if(_formkey.currentState!.validate()){
      _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()
      ).then((value){
        setState(() {
          loading=false;
        });

        Fluttertoast.showToast(
            msg: "User Successfully Registered",
        toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );

        // that a Scafold messenger
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Data Successfully added!"))
        // );

      }).onError((error, stackTrace) {
        setState(() {
          loading=false;
        });
        Utills().toastMessage(error.toString());
      });
    }
  }

  FirebaseAuth _auth=FirebaseAuth.instance;

  bool securePassword=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

          title: Center(child: Text("SignUp"))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

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
                  signUp();

                },
                title: "SignUp"),

            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("If you have already Account? "),
                TextButton(onPressed: ( ){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }, child: Text("Login")),

              ],
            )


          ],
        ),
      ),
    );
  }
}