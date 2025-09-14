import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/core/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStore {
  static CollectionReference<EventModel> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection("events")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) {
            return EventModel.fromJson(snapshot.data()!);
          },
          toFirestore: (model, _) {
            return model.toJson();
          },
        );
  }

  static Future<void> createEvent(EventModel events) async {
    var doc = await getEventsCollection().doc();
    events.id = doc.id;
    await doc.set(events);
  }

  static Future<void> UpdateEvent(EventModel events, String id) async {
    final doc = await getEventsCollection();

    await doc.doc(id).update(events.toJson());
  }

  static Future<void> updateEvent(String eventId, bool isFave) async {
    return getEventsCollection().doc(eventId).update({"isFave": isFave});
  }

  static Stream<QuerySnapshot<EventModel>> getEventById({required String id}) {
    if (id.isNotEmpty) {
      return getEventsCollection()
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('id', isEqualTo: id)
          .snapshots();
    } else {
      return const Stream.empty();
    }
  }

  static Future<void> deleteEventById({required String id}) async {
    if (id.isNotEmpty) {
      await getEventsCollection().doc(id).delete();
    }
  }

  static Stream<QuerySnapshot<EventModel>> getAllEvents({
    String? categoryName,
    bool? isFave,
  }) {
    if (isFave == true) {
      return getEventsCollection()
          .where('isFave', isEqualTo: isFave)
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();
    }
    if (categoryName == "all".tr()) {
      return getEventsCollection()
          .orderBy('date', descending: true)
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();
    } else {
      return getEventsCollection()
          .where('categoryName', isEqualTo: categoryName)
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('date', descending: true)
          .snapshots();
    }
  }
}
