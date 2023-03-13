import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:halka_arz_temettu/Providers/BedelliProvider.dart';
import 'package:halka_arz_temettu/Providers/BedelsizProvider.dart';
import 'package:halka_arz_temettu/Providers/TemettuProvider.dart';
import 'package:halka_arz_temettu/Screens/BedelliPage.dart';
import 'package:halka_arz_temettu/Screens/BedelsizPage.dart';
import 'package:provider/provider.dart';
import '../Providers/HalkaArzProvider.dart';
import 'Arzlar.dart';
import 'TemettuPage.dart';
class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  late final bannerAd;
  final String adUnitId="ca-app-pub-9615090811972947/1576276672";
  late final interStialAd;
  final String AdUnitIdInterStial="ca-app-pub-9615090811972947/6331292795";

  void initState(){

    super.initState();

    bannerAd=BannerAd(
        size: AdSize.banner,
        adUnitId: adUnitId,
        listener: bannerAdListener,
        request: const AdRequest()



    );
    bannerAd.load();
    _loadInterStialAd();

  }

  final BannerAdListener bannerAdListener=BannerAdListener(

      onAdLoaded: (Ad ad)=>print("AdLoaded"),
      onAdFailedToLoad: (Ad ad,LoadAdError error){

        ad.dispose();
        print("error $error");
      }

  );

  void _loadInterStialAd() {
    InterstitialAd.load(adUnitId: AdUnitIdInterStial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad){
              interStialAd=ad;

              _setFullScreenContentCallBack(ad);
            },
            onAdFailedToLoad: (LoadAdError loadAdError){
              print('$loadAdError');
            })
    );
  }
  void _setFullScreenContentCallBack(InterstitialAd ad) {
    ad.fullScreenContentCallback=FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad)=>print("$ad onAdShowedFullScreenContent"),
      onAdDismissedFullScreenContent: (InterstitialAd ad){
        print("$ad onAdDismissedFullScreenContent");
        ad.dispose();

      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad,AdError error){

        print("$ad onAdDismissedFullScreenContent : $error");
      },

      onAdImpression: (InterstitialAd ad)=>print("$ad Impression occured"),
    );


  }
  void _showInterstialAd(){

    interStialAd.show();
  }
  Widget build(BuildContext context) {
    final AdWidget adWidget=AdWidget(ad: bannerAd);
    final Container adContainer=Container(
      alignment: Alignment.center,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: adWidget,


    );
    return Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/Tl.png"),fit: BoxFit.cover)),
      child: Scaffold(backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height*0.8,
          child: ListView(
            children: [
              Column(
                children: [
Row(mainAxisAlignment: MainAxisAlignment.center,
  children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(35, 45),topLeft: Radius.elliptical(45, 55))),height: 200,width:MediaQuery.of(context).size.width*0.4,
          child: OutlinedButton(onPressed: () async {

            if(Provider.of<TemettuProvider>(context,listen: false).isClickedTemettu==false){
              await Provider.of<TemettuProvider>(context,listen: false).GetTemettu();
              Provider.of<TemettuProvider>(context,listen: false).isClickedTemettu=true;
            }
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TemettuPage()));
            _showInterstialAd();
          }, child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/temettu.png"),
                  ),
                  Text("Temettü",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                  Text("Takvimi",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          )),
        ),
      ),
      Container(decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(topRight: Radius.elliptical(55, 65),bottomLeft: Radius.elliptical(55, 45))),height: 200,width: MediaQuery.of(context).size.width*0.4,
        child: OutlinedButton(onPressed: ()async{

          if(Provider.of<HalkaArzProvider>(context,listen: false).isClickedHalkaArz==false){
            await Provider.of<HalkaArzProvider>(context,listen: false).GetHaLkaArz();
            Provider.of<HalkaArzProvider>(context,listen: false).isClickedHalkaArz=true;
          }

          Navigator.push(context, MaterialPageRoute(builder: (context)=>HalkaArzPage()));
          _showInterstialAd();

        }, child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/halkaArz.png"),
          ),
            Text("Halka Arz",style: TextStyle(fontSize: 20)),
            Text("Takvimi",style: TextStyle(fontSize: 20)),
          ],
        )),
      ),
  ],
),
                  SizedBox(height: MediaQuery.of(context).size.height*0.1,),


                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(decoration: BoxDecoration(color: Colors.indigo,borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(45, 55),topRight: Radius.elliptical(55, 40))),width: MediaQuery.of(context).size.width*0.4,height: 200,
                          child: OutlinedButton(onPressed: ()async{

                            if( Provider.of<BedelsizProvider>(context,listen: false).isClickedBedelsiz==false){
                              await  Provider.of<BedelsizProvider>(context,listen: false).GetBedelsiz();
                              Provider.of<BedelsizProvider>(context,listen: false).isClickedBedelsiz=true;
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BedelsizPage()));
                            _showInterstialAd();

                          }, child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/Bedelsiz.png"),
                              ),
                              Text("Bedelsiz",style: TextStyle(color: Colors.amber,fontSize: 20,fontWeight: FontWeight.bold)),
                              Text("Tablosu",style: TextStyle(color: Colors.amber,fontSize: 20,fontWeight: FontWeight.bold)),
                            ],
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(45, 40),topRight: Radius.circular(35.0))),height: 200,width: MediaQuery.of(context).size.width*0.4,
                          child: OutlinedButton(onPressed: ()async {


                            if(Provider.of<BedelliProvider>(context,listen: false).isBedelliClicked==false){

                              await Provider.of<BedelliProvider>(context,listen: false).getBedelli();
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BedelliPage()));
                            _showInterstialAd();
                          }, child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/Bedelli.png"),
                              ),
                              Text("Bedelli",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
                              Text("Tablosu",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
                            ],
                          )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15,),
              adContainer,


            ],
          ),
        ),
      ),
    );
  }
}
