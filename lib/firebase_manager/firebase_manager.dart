import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:wireless_build/data_model/data_class.dart';

bool? isExist;
List<String> IdList=[];

CollectionReference getTaskCollection() {
  return FirebaseFirestore.instance.collection('users').withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (task, _) => task.toJson(),
      );
}

Future<void> addTaskToFirebase(User user) async {
  var collection = getTaskCollection();
  var docRef = collection.doc(user.userId);
  return await docRef.set(user);
}

QuerySnapshot<User>? getUsersFromFirestore(String id) {
  return getTaskCollection().where('userId', isEqualTo: id).snapshots()
      as QuerySnapshot<User>;
}

Future getAllDocument() async {
    await getTaskCollection().get().then((value) => value.docs.forEach((element) {
      IdList.add(element.id);
      
    }));
    //print(IdList);
  
}
