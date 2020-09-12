import 'package:flutter/material.dart';
import 'package:show_wallpaper/screen01.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(AdExampleApp());
}

class AdExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentic HD Wallpapers',
      theme: ThemeData(),
      home: SafeArea(
        child: Scaffold(
          body: AdsPage(),
        ),
      ),
    );
  }
}
