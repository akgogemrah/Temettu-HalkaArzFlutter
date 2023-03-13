
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:halka_arz_temettu/Screens/MenuPage.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}
var data;
class _LoginPageState extends State<LoginPage> {
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


  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget=AdWidget(ad: bannerAd);
    final Container adContainer=Container(
      alignment: Alignment.center,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: adWidget,


    );

    return MaterialApp(
      home: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/investor.png"),fit: BoxFit.fill)),
        child: Scaffold(backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.3,),

                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuPage()));
                  }, child: Text("Giriş Yapın")),



                  SizedBox(height: 10,),
                  adContainer
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


