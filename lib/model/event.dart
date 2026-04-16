import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  String?id;
  String? userid;
  String?title;
  String?desc;
  String?type;
  Timestamp? dateAndTime;
  Event({this.title,this.desc,this.type,this.dateAndTime,this.id,this.userid});
  Event.fromFirestore(Map<String,dynamic>?data)
  {
    title=data?["title"];
    desc=data?["desc"];
    type=data?["type"];
    dateAndTime=data?["dateAndTime"];
    id=data?["id"];
    userid=data?["userid"];
  }

  Map<String,dynamic> toFirestore(){
    return {
      "title":title,
      "desc":desc,
      "type":type,
      "dateAndTime":dateAndTime,
      "id":id,
      "userid":userid
    };
  }

}