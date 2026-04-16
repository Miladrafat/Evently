import 'package:flutter/material.dart';

import '../../../../../core/remote/network/Firestoremanager.dart';
import '../../../../../model/event.dart';
import '../../../widgets/event_item.dart';
import '../../../widgets/eventlist.dart';

class BookView extends StatelessWidget {
  const BookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Eventlist(type: "Book",);
  }
}
