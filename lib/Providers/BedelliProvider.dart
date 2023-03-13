import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class BedelliProvider extends ChangeNotifier{
  late bool isBedelliClicked=false;
  List<String>code=List.empty(growable: true);
  List<String>date=List.empty(growable: true);
  List<String>percentage=List.empty(growable: true);
 final _databaseBedelli=FirebaseFirestore.instance;
 Future getBedelli()async{
   await _databaseBedelli.collection("Bedelli").get().then((value) => value.docs.forEach((element) {
     Map<String,dynamic> matter=element.data();
code.add(matter["code"]);
date.add(matter["date"]);
percentage.add(matter["percentage"]);
   }));
   print(code);
   print(date);
   print(percentage);
 }
}