import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class HalkaArzProvider extends ChangeNotifier{
  late List<String?>startDate=List.empty(growable: true);
  late List<String?> url=List.empty(growable: true);
  late List<String?>code=List.empty(growable: true);
  late List<String?>endDate=List.empty(growable: true);
  late List<String?>DagitimTuru=List.empty(growable: true);
  late List<String?>FiyatIstikrar=List.empty(growable: true);
  late List<String?>Pazar=List.empty(growable: true);
  late List<double?>Price=List.empty(growable: true);
  late List<String?>Quantity=List.empty(growable: true);
  late List<String?> name=List.empty(growable: true);
late bool isClickedHalkaArz=false;
  Future GetHaLkaArz()async{
    await  FirebaseFirestore.instance.collection("HalkaArz").orderBy("order",descending: false).get().then((snapshots) =>snapshots.docs.forEach((element)async {
      Map<String,dynamic> matter=element.data();
      name.add(matter["Hisse"]);
      code.add(matter["code"]);
      startDate.add(matter["BaslangıcTarihi"]);
      endDate.add(matter["BitisTarihi"]);
      DagitimTuru.add(matter["DagitimTuru"]);
      FiyatIstikrar.add(matter["FiyatIstikrar"]);
      Pazar.add(matter["pazar"]);
      Price.add(matter["price"]);
      Quantity.add(matter["quantity"]);
    }));
    await FirebaseFirestore.instance.collection("Links").orderBy("order",descending: false).get().then((snapshots) =>snapshots.docs.forEach((element) {
      Map<String,dynamic> matter=element.data();
      url.add(matter["Link"]);
    }) );
  }
}