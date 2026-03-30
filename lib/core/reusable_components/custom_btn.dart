import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  String title;
  void Function() onClick;
  CustomBtn({required this.title,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16)
          )
        ),
        child: Text(title,style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w500
        ),)
    );
  }
}
