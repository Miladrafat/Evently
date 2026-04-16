import 'package:firebase_auth/firebase_auth.dart';

class User{
  String?id;
  String?name;
  String?email;
  List<String>? Favourites;
  User({this.id,this.name,this.email,this.Favourites});
  User.fromFirestore(Map<String,dynamic>?data)
  {
    id=data?["id"];
    name=data?["name"];
    email=data?["email"];
    Favourites=List<String>.from(data?["Favourites"]??[]);
  }

  Map<String,dynamic> toFirestore(){
    return {
      "id":id,
      "name":name,
      "email":email,
      "Favourites":Favourites
    };
  }
}