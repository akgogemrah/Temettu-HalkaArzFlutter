import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class BedelsizProvider extends ChangeNotifier{
  bool isClickedBedelsiz=false;
  List<String> code=List.empty(growable: true);
  List<String>percentage=List.empty(growable: true);
  List<String>date=List.empty(growable: true);
  final _database=FirebaseFirestore.instance;
  Future GetBedelsiz()async{
  await _database.collection("Bedelsiz").get().then((value) => value.docs.forEach((element) {
    Map<String,dynamic> matter=element.data();
    code.add(matter["code"]);
    percentage.add(matter["percentage"]);
    date.add(matter["date"]);
  }));
  }
}