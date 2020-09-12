import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:show_wallpaper/Screen03.dart';
import 'package:show_wallpaper/background.dart';
import 'package:show_wallpaper/roundedbutton.dart';
import 'package:show_wallpaper/screen02.dart';

class AdsPage extends StatefulWidget {
  @override
  AdsPageState createState() => AdsPageState();
}

class AdsPageState extends State<AdsPage> {
  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;
  bool _isRewardedVideoComplete = false;

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
        placementId: "2592834000928344_2592855810926163",
        //     "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid

        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
//      FacebookAudienceNetwork.init(
//        testingId: "003fc852-2b35-4389-813e-e4fc63919fe4",
//      );
    });

    _loadInterstitialAd();
    _loadRewardedVideoAd();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
//      placementId: "2592834000928344_2592834950928249",
      placementId:
          "IMG_16_9_APP_INSTALL#2592834000928344_259283495092824", //"IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617" YOUR_PLACEMENT_ID
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

  void _loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) _isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)
          _isRewardedVideoComplete = true;

        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            value["invalidated"] == true) {
          _isRewardedAdLoaded = false;
          _loadRewardedVideoAd();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Authentic HD Wallpapers",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.purple[800]),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
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
            RoundedButton(
              text: "SIGN UP",
              textColor: Colors.white,
              press: () {
                _showInterstitialAd();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Screen02();
                    },
                  ),
                );
              },
            ),
          ],
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

  _showRewardedAd() {
    if (_isRewardedAdLoaded == true)
      FacebookRewardedVideoAd.showRewardedVideoAd();
    else
      print("Rewarded Ad not yet loaded!");
  }

  _showInStreamAd() {
    setState(() {
      _currentAd = FacebookInStreamVideoAd(
        height: 300,
        listener: (result, value) {
          print("In-Stream Ad: $result -->  $value");
          if (result == InStreamVideoAdResult.VIDEO_COMPLETE) {
            setState(() {
              _currentAd = SizedBox(
                height: 0,
                width: 0,
              );
            });
          }
        },
      );
    });
  }

  _showBannerAd() {
    setState(() {
      _currentAd = FacebookBannerAd(
        // placementId:
        //     "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
        placementId: "2549649871919370_2549651808585843",
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
  }

  _showNativeBannerAd() {
    setState(() {
      _currentAd = _nativeBannerAd();
    });
  }

  Widget _nativeBannerAd() {
    return FacebookNativeAd(
      placementId: "2549649871919370_2550442425173448",
      // placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      width: double.infinity,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    );
  }

  _showNativeAd() {
    setState(() {
      _currentAd = _nativeAd();
    });
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      placementId: "2549649871919370_2550440251840332",
      // placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
      adType: NativeAdType.NATIVE_AD,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: false,
      expandAnimationDuraion: 1000,
    );
  }
}
