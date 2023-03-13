import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../Providers/TemettuProvider.dart';
class TemettuPage extends StatefulWidget {
  @override
  State<TemettuPage> createState() => _TemettuPageState();
}
class _TemettuPageState extends State<TemettuPage> {
  @override
  late final bannerAd;
  final String adUnitId="ca-app-pub-9615090811972947/1576276672";

  void initState(){

    super.initState();
    bannerAd=BannerAd(
        size: AdSize.banner,
        adUnitId: adUnitId,
        listener: bannerAdListener,
        request: const AdRequest()



    );
    bannerAd.load();

  }
  final BannerAdListener bannerAdListener=BannerAdListener(

      onAdLoaded: (Ad ad)=>print("AdLoaded"),
      onAdFailedToLoad: (Ad ad,LoadAdError error){

        ad.dispose();
        print("error $error");
      }

  );
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
        () => 'Data Loaded',
  );
  Widget build(BuildContext context) {
    final AdWidget adWidget=AdWidget(ad: bannerAd);
    final Container adContainer=Container(
      alignment: Alignment.center,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: adWidget,


    );
    return Scaffold(backgroundColor: Colors.blueGrey,
      body: FutureBuilder(future: _calculation, builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if(snapshot.hasError){
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(child: Text("Temettü Tablosu",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.amber),)),
            ),
            Container(height: MediaQuery.of(context).size.height*0.85,
              child: Scrollbar(
                child: ListView.builder(itemCount: Provider.of<TemettuProvider>(context).urlTemettu.length, itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [

Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Card(
    child: ExpansionTile(leading: Text(Provider.of<TemettuProvider>(context).temettupercentage[index].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple)),backgroundColor: Colors.blueGrey,title: Text(Provider.of<TemettuProvider>(context).temettuCode[index]!,style: TextStyle(fontWeight: FontWeight.bold)),subtitle:Text("Dağıtım tarihi  : ${Provider.of<TemettuProvider>(context).temettuDate[index]}",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)) ,children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Temettü oranı : ${Provider.of<TemettuProvider>(context).temettupercentage[index]}",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: 20)),
    ),
      Text("Lot başına verilicek tutar : ${Provider.of<TemettuProvider>(context).temettuprice[index]}",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white)),
      Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(Provider.of<TemettuProvider>(context).urlTemettu[index]!),
      ),
    ],),
  ),
),

                    ],
                  );
                },),
              )
              ),
            adContainer
          ],
        );
      },),
    );
  }
}
