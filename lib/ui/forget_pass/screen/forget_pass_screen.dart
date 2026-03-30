import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/reusable_components/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/reusable_components/back_btn.dart';

class ForgetPassScreen extends StatelessWidget {
  static const String routeName = "forgetPass";
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManager.forgetPass),
        leading: BackBtn(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 40,
          children: [
            Image.asset(AssetsManager.forgetPass),
            SizedBox(
              width: double.infinity,
              child: CustomBtn(title: StringsManager.resetPass, onClick: () {

              },),
            )
          ],
        ),
      ),
    );
  }
}
