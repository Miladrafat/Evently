import 'package:flutter/material.dart';

import '../../../core/remote/network/Firestoremanager.dart';
import '../../../model/event.dart';
import 'event_item.dart';

class Eventlist extends StatelessWidget {
  String? type;
   Eventlist({super.key,this.type});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: type ==null ? Firestoremanager.getAllEventStream():Firestoremanager.getAllEventFilterdStream(type!),
      builder:(context, snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()));
        }
       
        List<Event>events=snapshot.data??[];
        if (events.isEmpty){
          return Center(child: Text("No data Available"));
        }
        return ListView.separated(
            itemBuilder: (context, index) => EventItem(event: events[index]),
            separatorBuilder: (context, index) => SizedBox(height: 16,),
            itemCount: events.length
        );

      },);
  }
}
