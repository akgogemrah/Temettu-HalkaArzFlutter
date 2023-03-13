import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class TemettuProvider extends ChangeNotifier{
 late bool isClickedTemettu=false;
  late List<String?> urlTemettu=List.empty(growable: true);
  late List<String?> temettuCode=List.empty(growable: true);
  late List<String?> temettuDate=List.empty(growable: true);
  late List<String?> temettupercentage=List.empty(growable: true);
  late List<String?> temettuprice=List.empty(growable: true);
 final _database=FirebaseFirestore.instance;
 Future GetTemettu()async{
   await _database.collection("TemettuLinks").orderBy("order",descending: false).get().then((snapshots) => snapshots.docs.forEach((element) {
     Map<String,dynamic> matter=element.data();
     urlTemettu.add(matter["Link"]);
   }));
   await _database.collection("Temettüler").orderBy("order",descending: false).get().then((snapshots) =>snapshots.docs.forEach((element) {
     Map<String,dynamic> matter2=element.data();
     temettuCode.add(matter2["code"]);
     temettuDate.add(matter2["date"]);
     temettupercentage.add(matter2["percentage"]);
     temettuprice.add(matter2["price"]);
   }));
 }
}