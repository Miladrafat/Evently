import 'package:flutter/material.dart';

import '../../../../../core/remote/network/Firestoremanager.dart';
import '../../../../../model/event.dart';
import '../../../widgets/event_item.dart';
import '../../../widgets/eventlist.dart';

class ExhibitionView extends StatelessWidget {
  const ExhibitionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Eventlist(type: "Exhibition",);
  }
}
