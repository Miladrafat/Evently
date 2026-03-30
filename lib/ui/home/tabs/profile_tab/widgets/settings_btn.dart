import 'package:flutter/material.dart';

class SettingsBtn extends StatelessWidget {
  String title;
  Widget child;
  void Function()? onPress;
  SettingsBtn({required this.title,required this.child,this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16
        ) ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
           border: Border.all(color: Theme
               .of(context)
               .colorScheme
               .outline),
          color: Theme
              .of(context)
              .colorScheme
              .onSecondary,

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500
            ),),
            child
          ],
        ),
      ),
    );
  }
}
