import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final title;
  final VoidCallback onTab;
  final bool loading;
  const RoundButton({super.key ,required this.title, required this.onTab, this.loading=false,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(child:loading? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,):
        Text(title , style: TextStyle(color: Colors.white, fontSize: 20),)),
      ),
    );
  }
}