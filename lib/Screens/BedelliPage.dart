import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:halka_arz_temettu/Providers/BedelliProvider.dart';
import 'package:provider/provider.dart';

class BedelliPage extends StatefulWidget {
  const BedelliPage({Key? key}) : super(key: key);

  @override
  State<BedelliPage> createState() => _BedelsizPageState();
}

class _BedelsizPageState extends State<BedelliPage> {
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
  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget=AdWidget(ad: bannerAd);
    final Container adContainer=Container(
      alignment: Alignment.center,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: adWidget,


    );
    return FutureBuilder(future: _calculation, builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

      return Scaffold(backgroundColor: Colors.blueGrey,appBar: AppBar(backgroundColor: Colors.amber,centerTitle: true,title: Text("Bedelli Tablosu")),
        body: Column(
          children: [
            Container(height: MediaQuery.of(context).size.height*0.7,
              child: Scrollbar(
                child: ListView.builder(itemCount: Provider.of<BedelliProvider>(context).code.length, itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(color: Colors.white,child: ListTile(trailing: Text(Provider.of<BedelliProvider>(context).percentage[index],style: TextStyle(fontWeight: FontWeight.bold)),subtitle: Text("Tarih : ${Provider.of<BedelliProvider>(context).date[index]}"),title: Text(Provider.of<BedelliProvider>(context).code[index],style: TextStyle(fontWeight: FontWeight.bold)),)),
                  );
                },),
              ),
            ),
            adContainer
          ],
        ),
      );

    },);
  }
}
