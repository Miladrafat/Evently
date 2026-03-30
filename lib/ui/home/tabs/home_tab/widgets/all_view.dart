import 'package:evently_c18/ui/home/widgets/event_item.dart';
import 'package:flutter/material.dart';

class AllView extends StatelessWidget {
  const AllView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => EventItem(),
        separatorBuilder: (context, index) => SizedBox(height: 16,),
        itemCount: 10
    );
  }
}
