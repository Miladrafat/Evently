import 'package:evently_c18/core/remote/network/Firestoremanager.dart';
import 'package:evently_c18/model/event.dart';
import 'package:evently_c18/ui/home/widgets/event_item.dart';
import 'package:flutter/material.dart';

import '../../../widgets/eventlist.dart';

class AllView extends StatelessWidget {
  const AllView({super.key});

  @override
  Widget build(BuildContext context) {
    return Eventlist();
  }
}
