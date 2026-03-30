import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/AssetsManager.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: SvgPicture.asset(AssetsManager.back)
    );
  }
}
