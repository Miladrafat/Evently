import 'package:flutter/material.dart';

import '../../../widgets/event_item.dart';

class ExhibitionView extends StatelessWidget {
  const ExhibitionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => EventItem(),
        separatorBuilder: (context, index) => SizedBox(height: 16,),
        itemCount: 10
    );
  }
}
