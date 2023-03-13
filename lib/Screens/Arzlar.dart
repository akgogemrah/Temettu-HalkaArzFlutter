
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:halka_arz_temettu/Providers/HalkaArzProvider.dart';
import 'package:provider/provider.dart';
class HalkaArzPage extends StatefulWidget {
  @override
  State<HalkaArzPage> createState() => _HalkaArzPageState();
}
class _HalkaArzPageState extends State<HalkaArzPage> {
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
    const Duration(seconds: 2),
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
    return Scaffold(
      body: FutureBuilder(future:_calculation, builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
       return Container(height: MediaQuery.of(context).size.height*0.9,
         child: ListView.builder(itemCount: Provider.of<HalkaArzProvider>(context).url.length, itemBuilder: (BuildContext context, int index) {
          return Column(
              children: [
                SizedBox(height: 10,),
           Card(
             child: ExpansionTile(
          title: Text("${Provider.of<HalkaArzProvider>(context).name[index]!} - "+Provider.of<HalkaArzProvider>(context).code[index]!,style: TextStyle(fontWeight: FontWeight.bold)),
             subtitle: Text(Provider.of<HalkaArzProvider>(context).DagitimTuru[index]!+""+"Satış Fiyatı : ${Provider.of<HalkaArzProvider>(context).Price[index]}₺",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo)),
             children: <Widget>[
             ListTile(leading: Image.network(Provider.of<HalkaArzProvider>(context).url[index]!),title: Column(
               children: [
                 Text("Talep Toplama Tarihi :${Provider.of<HalkaArzProvider>(context).startDate[index]}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                 SizedBox(height: 10,),
                 Text("Talep Toplama Bitiş   :${Provider.of<HalkaArzProvider>(context).endDate[index]} ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                 SizedBox(height: 10,),
               Text("  Arz Edilecek Lot  ${Provider.of<HalkaArzProvider>(context).Quantity[index]}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                 SizedBox(height: 10,),
               Text(Provider.of<HalkaArzProvider>(context).FiyatIstikrar[index]!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                 SizedBox(height: 10,),
                Text(Provider.of<HalkaArzProvider>(context).Pazar[index]!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
               ],
             )),
             ],

             ),
           ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: adContainer,
                )

],

          );
         },),
       );
      },),
    );

  }




}
