import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsBtn extends StatelessWidget {
  Color background;
  String? text;
  String? imagePath;
  Color childColor;
  bool isSelected;
  void Function() onClick;
  SettingsBtn({super.key,required this.background,
    required this.isSelected,
    required this.onClick,
    this.text,this.imagePath,required this.childColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: 16,
          vertical: 6
        ),
        decoration: BoxDecoration(
          color: isSelected?background:Theme
              .of(context)
              .colorScheme
              .onSecondary,
          borderRadius: BorderRadius.circular(8)
        ),
        child: imagePath!=null
            ?SvgPicture.asset(imagePath!,colorFilter: ColorFilter.mode(
            childColor,
            BlendMode.srcIn
        ),)
            :Text(text!,style: isSelected
            ?Theme.of(context).textTheme.labelMedium
            :Theme.of(context).textTheme.titleSmall),
      ),
    );
  }
}
