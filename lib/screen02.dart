import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:show_wallpaper/Screen03.dart';

import 'package:show_wallpaper/backgroundSignup.dart';
import 'package:show_wallpaper/components/already_have_an_account_acheck.dart';
import 'package:show_wallpaper/components/rounded_input_field.dart';
import 'package:show_wallpaper/components/rounded_password_field.dart';
import 'package:show_wallpaper/roundedbutton.dart';
import 'package:flutter_svg/svg.dart';
import 'package:show_wallpaper/screen04.dart';

class Screen02 extends StatefulWidget {
  @override
  Screen02State createState() => Screen02State();
}

class Screen02State extends State<Screen02> {
  bool _isInterstitialAdLoaded = false;

  /// All widget ads are stored in this variable. When a button is pressed, its
  /// respective ad widget is set to this variable and the view is rebuilt using
  /// setState().
  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentAd = FacebookBannerAd(
        // placementId:
        //     "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
        placementId: "2592834000928344_2592855810926163",

        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
//    FacebookAudienceNetwork.init(
//      testingId: "003fc852-2b35-4389-813e-e4fc63919fe4",
//    );

    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "2592834000928344_2592834950928249",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackgroundSignUp(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.purple[800]),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () {
                  _showInterstitialAd();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Screen04();
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  _showInterstitialAd();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Screen03();
                      },
                    ),
                  );
                },
              ),
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
