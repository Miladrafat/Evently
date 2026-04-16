import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c18/model/event.dart';
import 'package:evently_c18/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as myuser;

class Firestoremanager {
  /////user
  static CollectionReference<User> getUserCollotion() {
    var collection = FirebaseFirestore.instance
        .collection("User")
        .withConverter(
          fromFirestore: (snapshot, options) {
            User user = User.fromFirestore(snapshot.data());
            return user;
          },
          toFirestore: (value, options) {
            return value.toFirestore();
          },
        );
    return collection;
  }
  static Future<void> saveuser(User user) {
    var collection = getUserCollotion();
    var document = collection.doc(user.id);
    return document.set(user);
  }
  static Future<User?> getuser() async {
    var collection = getUserCollotion();
    var document = collection.doc(myuser.FirebaseAuth.instance.currentUser!.uid);
    var snapshot = await document.get();
    var User = snapshot.data();
    return User;
  }
  /////////////////////////////////////////////
  ////////Event
  static CollectionReference<Event> getEventCollotion() {
    var collection = FirebaseFirestore.instance
        .collection("Event")
        .withConverter(
          fromFirestore: (snapshot, options) {
            Event event = Event.fromFirestore(snapshot.data());
            return event;
          },
          toFirestore: (value, options) {
            return value.toFirestore();
          },
        );
    return collection;
  }
  static Future<void> addEvent(Event event) {
    var collection = getEventCollotion();
    var document = collection.doc();
    event.id = document.id;
    return document.set(event);
  }
   static Future<void> updateEvent(Event event) async {
     if (event.id == null) throw Exception('Event id is null');
     final currentUser = myuser.FirebaseAuth.instance.currentUser;
     if (currentUser == null) {
       throw Exception('User not authenticated');
     }
     
     if (event.userid == null || event.userid != currentUser.uid) {
       throw Exception('You are not the owner of this event');
     }
     
     var collection = getEventCollotion();
     var document = collection.doc(event.id);
     return document.set(event);
   }
  static Future<Event?> getEvent() async {
    var collection = getEventCollotion();
    var document = collection.doc();
    var snapshot = await document.get();
    var event = snapshot.data();
    return event;
  }
  static Future<List<Event>?> getAllEventbymyway() async {
    var collotion = getEventCollotion();
    var querySnapshot = await collotion.get();
    var docsList = querySnapshot.docs;
    List<Event> AllEvent = docsList
        .map(
          (e) => Event.fromFirestore({
            "title": docsList.map((l) => l.data().title),
            "desc": docsList.map((l) => l.data().desc),
            "type": docsList.map((l) => l.data().type),
            "dateAndTime": docsList.map((l) => l.data().dateAndTime),
            "userid": docsList.map((l) => l.data().userid),
            "id": docsList.map((l) => l.data().id),
          }),
        )
        .toList();
    return AllEvent;
  }
  static Future<List<Event>> getAllEvent() async {
    var collection = getEventCollotion();
    var querySnapshot = await collection.get();
    var docsList = querySnapshot.docs;
    var eventList = docsList.map((e) => e.data()).toList();
    return eventList;
  }
  static Future<List<Event>> getFilteredEvent(String type) async {
    var collection = getEventCollotion().where("type", isEqualTo: type);
    var querySnapshot = await collection.get();
    var docsList = querySnapshot.docs;
    var eventList = docsList.map((e) => e.data()).toList();
    return eventList;
  }
  static Stream<List<Event>> getAllEventStream() async* {
    var collection = getEventCollotion();
    var querySnapshotStream = collection.snapshots();
    var docsStream = querySnapshotStream.map(
      (querySnapshot) => querySnapshot.docs,
    );
    var eventStream = docsStream.map(
      (docList) => docList.map((document) => document.data()).toList(),
    );
    yield* eventStream;
  }
  static Stream<List<Event>> getAllEventFilterdStream(String type) async* {
    var collection = getEventCollotion().where("type", isEqualTo: type);
    var querySnapshotStream = collection.snapshots();
    var docsStream = querySnapshotStream.map(
      (querySnapshot) => querySnapshot.docs,
    );
    var eventStream = docsStream.map(
      (docList) => docList.map((document) => document.data()).toList(),
    );
    yield* eventStream;
  }

  //////////////////////////////////////////////////////////////////////
  ///// Favourite
  static CollectionReference<Event> getFavourite() {
    var userCollection = getUserCollotion();
    var userDocument = userCollection.doc(myuser.FirebaseAuth.instance.currentUser!.uid,);
    var Favouritecollection = userDocument.collection("Favourites")
        .withConverter(
          fromFirestore: (snapshot, options) {
            return Event.fromFirestore(snapshot.data());
          },
          toFirestore: (value, options) {
            return value.toFirestore();
          },
        );

    return Favouritecollection;
   }
   static Future<void> addFavourite(Event event) {
     var collection = getFavourite();
     var document = collection.doc(event.id);
     print("Adding favourite - Event ID: ${event.id}");
     return document.set(event);
   }
   static Future<void> updateUserFavourite(List<String>?Favourites){
     var currentUserId = myuser.FirebaseAuth.instance.currentUser?.uid;
     if(currentUserId == null) {
       print("Error: User not authenticated");
       throw Exception("User not authenticated");
     }
     var collection=getUserCollotion();
     var document=collection.doc(currentUserId);
     // التأكد من أن Favourites ليست null
     List<String> favList = Favourites ?? [];
     print("Updating Favourites for user: $currentUserId with: $favList");
     return document.update({"Favourites":favList});
   }
   static Future<void> deleteUserFavourite(Event? event ){
     var collection =  getFavourite();
     var document = collection.doc(event!.id);
     print("Deleting favourite - Event ID: ${event.id}");
     return document.delete();
   }
  static Stream<List<Event>?> getFavouriteStream() async* {
    var collection = getFavourite();
    var querySnapshotStream = collection.snapshots();
    var docsStream = querySnapshotStream.map(
          (querySnapshot) => querySnapshot.docs,
    );
    var eventStream = docsStream.map(
          (docList) => docList.map((document) => document.data()).toList(),
    );
    yield* eventStream;
  }

   static Future<void> deleteEventAndCleanup(String eventId, {String? userId}) async {
     final firestore = FirebaseFirestore.instance;
     if (userId != null) {
       final currentUser = myuser.FirebaseAuth.instance.currentUser;
       if (currentUser == null) {
         throw Exception('User not authenticated');
       }
       if (userId != currentUser.uid) {
         throw Exception('You are not the owner of this event');
       }
     }
     
     // 1) Delete the event document
     await getEventCollotion().doc(eventId).delete();

     // 2) Get all users
     final usersSnapshot = await firestore.collection('User').get();
     for (final userDoc in usersSnapshot.docs) {
       try {
         // Remove from subcollection 'Favourites' if exists
         final favDocRef = userDoc.reference.collection('Favourites').doc(eventId);
         final favSnapshot = await favDocRef.get();
         if (favSnapshot.exists) {
           await favDocRef.delete();
         }

         // Also make sure to remove from the Favourites array field if present
         await userDoc.reference.update({
           'Favourites': FieldValue.arrayRemove([eventId])
         });
       } catch (e) {
         // Log and continue with other users - keep cleanup best-effort
         print('Error cleaning favourites for user ${userDoc.id}: $e');
       }
     }
   }
  static Future<void> propagateEventUpdate(Event event) async {
    if (event.id == null) throw Exception('Event id is null');
    final firestore = FirebaseFirestore.instance;
    final usersSnapshot = await firestore.collection('User').get();

    for (final userDoc in usersSnapshot.docs) {
      try {
        final favDocRef = userDoc.reference.collection('Favourites').doc(event.id);
        final favSnapshot = await favDocRef.get();
        if (favSnapshot.exists) {
          // overwrite the stored favourite copy with the updated event
          await favDocRef.set(event.toFirestore());
        }
      } catch (e) {
        print('Error propagating event update to user ${userDoc.id}: $e');
      }
    }
  }
}
