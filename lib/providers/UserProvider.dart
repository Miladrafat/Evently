
import 'package:evently_c18/core/remote/network/Firestoremanager.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
class Userprovider extends ChangeNotifier{
  User? Myuser;
  
  fetchuser()async {
    Myuser=await Firestoremanager.getuser();
    // التأكد من أن Favourites ليست null
    if(Myuser != null && Myuser!.Favourites == null) {
      Myuser!.Favourites = [];
    }
    notifyListeners();
  }

  // تحديث الـ Favourites وإبلاغ جميع المستمعين
  updateFavourites(List<String>? favourites) async {
    if(Myuser != null) {
      Myuser!.Favourites = favourites ?? [];
      await Firestoremanager.updateUserFavourite(Myuser!.Favourites ?? []);
      notifyListeners();
    }
  }

}