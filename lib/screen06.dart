import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:show_wallpaper/Screen03.dart';
import 'package:show_wallpaper/components/rounded_button_02.dart';
import 'package:show_wallpaper/screen05.dart';
import 'package:show_wallpaper/screen07.dart';

import 'package:facebook_audience_network/facebook_audience_network.dart';

class Screen06 extends StatefulWidget {
  @override
  _Screen06State createState() => _Screen06State();
}

class _Screen06State extends State<Screen06> {
  bool _isInterstitialAdLoaded = false;

  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );
  @override
  void initState() {
    super.initState();
    _currentAd = FacebookBannerAd(
      placementId: "902091576955604_902098946954867",
      //     "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid

      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        print("Banner Ad: $result -->  $value");
      },
    );
    FacebookAudienceNetwork.init(
      testingId: "003fc852-2b35-4389-813e-e4fc63919fe4",
    );

    _loadInterstitialAd();
    _currentAd = FacebookBannerAd(
      // placementId:
      //     "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
      placementId: "346763216710266_346764586710129",
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        print("Banner Ad: $result -->  $value");
      },
    );
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: '2549649871919370_2550438575173833',
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/i.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 520, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RoundedButton02(
                text: "Previous",
                press: () {
                  _showInterstitialAd();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Screen05();
                      },
                    ),
                  );
                },
              ),
              RoundedButton02(
                text: "Next",
                press: () {
                  _showInterstitialAd();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Screen07();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstial Ad not yet loaded!");
  }
}
