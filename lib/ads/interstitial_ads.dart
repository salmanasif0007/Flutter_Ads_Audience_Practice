import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

class Interstitial extends StatefulWidget {
  @override
  InterstitialState createState() => InterstitialState();
}

class InterstitialState extends State<Interstitial> {
  bool _isInterstitialAdLoaded = false;

  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  @override
  void initState() {
    super.initState();

    FacebookAudienceNetwork.init(
      testingId: "b9f2908b-1a6b-4a5b-b862-ded7ce289e41",
    );

    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId:
          "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617", //"IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617" YOUR_PLACEMENT_ID
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Align(
            alignment: Alignment(0, -1.0),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: _showInterstitialAd(),
            ),
          ),
          fit: FlexFit.tight,
          flex: 2,
        ),
        Flexible(
          child: Align(
            alignment: Alignment(0, 1.0),
            child: _currentAd,
          ),
          fit: FlexFit.tight,
          flex: 3,
        )
      ],
    );
  }

  _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstial Ad not yet loaded!");
  }
}
