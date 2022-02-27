
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nasim_sir_project/main.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({ Key? key }) : super(key: key);

  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 4), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return MyApp();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterLogo(size: 2,),
    );
  }
}