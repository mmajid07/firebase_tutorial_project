import 'package:flutter/material.dart';

class CheckBoxScreen extends StatefulWidget {
    CheckBoxScreen({super.key});

  @override
  State<CheckBoxScreen> createState() => _CheckBoxScreenState();
}
class _CheckBoxScreenState extends State<CheckBoxScreen> {
  List<bool> myBoolList=[false,false,false,];
  List<String> myList=["Majid","Khan","Affan",];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckBox"),
      ),
      body: ListView.builder(
        itemCount: myList.length,
          itemBuilder: (context, index){
            return CheckboxListTile(
              title:Text(myList[index]) ,
                value: myBoolList[index],
                onChanged: (value){
                    setState(() {
                       myBoolList[index]=value!;
                    });
                },);
          }),
    );
  }
}
