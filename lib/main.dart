import 'package:crud/src/app/main_page.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget example1 = SplashScreenView(
      home: MainPage(),
      duration: 3000,
      imageSize: 200,
      text: "CRUD APP",
      imageSrc: "assets/logo.png",
      backgroundColor: Colors.white,
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
          color: Colors.deepPurple, fontSize: 30, fontWeight: FontWeight.bold),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: example1,
    );
  }
}
