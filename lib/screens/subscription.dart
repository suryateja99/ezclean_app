import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/custom_appbar.dart';

class Subscription extends StatefulWidget{
  const Subscription ({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _Subscription();
}

class _Subscription extends State<Subscription> {
  final double _borderRadius = 24;
  @override
  Widget build(BuildContext context){
    return  Scaffold(
        appBar: CustomAppBar(
        appTitle: 'Subscriptions',
        icon: const FaIcon(Icons.arrow_back_ios),
    ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children:<Widget> [
          Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children:<Widget> [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  gradient: LinearGradient(
                    colors: [Colors.pink, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 12,
                      offset: Offset(0,6),
                    )
                  ]
                  )
                ),
              Row(
                children: <Widget>[
                  Image.asset('assets/logo.png', height: 65,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(15)),
                      Text("WASH AND FOLD",style: TextStyle(color: Colors.white, fontFamily: 'Avenir', fontWeight: FontWeight.bold, fontSize: 30),),
                      Text("Rs 2999/-", style: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold, fontSize: 50),)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        ]
      ),
    );
  }
}