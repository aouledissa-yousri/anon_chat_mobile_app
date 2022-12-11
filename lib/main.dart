import 'package:anon_chat_mobile_app/display/pages/nonAuthPages/LandingPage.dart';
import 'package:flutter/material.dart';

import 'display/pages/requiresAuthPages/DashBoardPage.dart';
import 'helpers/DirectoryHelper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Widget startPage;

  @override 
  void initState() {
    // TODO: implement initState
    super.initState();

    this.loadStartPage().then((startPage) => setState(() { this.startPage = startPage;}));

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: this.startPage
      )
    );
  }

  Future<Widget> loadStartPage() async {
    dynamic userData = await DirectoryHelper.getUserData();

    try{
      JwtDecoder.decode(userData["token"]);
      return DashBoardPage();

    }catch(error){
      return LandingPage();
    }
  }


  




}