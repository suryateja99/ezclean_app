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
                    colors: [Colors.lightBlue, Colors.lightBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightBlue,
                      blurRadius: 5,
                      offset: Offset(0,3),
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
                      Text("WASH AND IRON",style: TextStyle(color: Colors.white, fontFamily: 'Avenir', fontWeight: FontWeight.bold, fontSize: 30),),

                      Text("Rs 2999/-", style: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold, fontSize: 50),)
                    ],
                  )
                ],
              )
            ],
          ),

        ),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns:  [
                  DataColumn(label:
                  Container(
                  margin: EdgeInsets.all(8),
                  child: Text('Services'),
                  )
                  ),
                  DataColumn(label: Container(
                    margin: EdgeInsets.all(8),
                    child: Text('Wash and Iron'),
                  )),
                ],
                rows:  [
                  DataRow(cells: [
                    DataCell(Container(width: 200, child: Text('Wash and Iron'))),
                    DataCell(Container(width: 100, child: Icon(Icons.check, color: Colors.green),)),
                  ]),
                  DataRow(cells: [
                    DataCell(Container(width: 200, child: Text('Premium Laundry'))),
                    DataCell(Container(width: 100, child: Icon(Icons.check, color: Colors.green),)),
                  ]),
                  DataRow(cells: [
                    DataCell(Container(width: 200, child: Text('Dry Cleaning'))),
                    DataCell(Container(width: 100, child: Text('FLAT 25% OFF'),)),
                  ]),
                  DataRow(cells: [
                    DataCell(Container(width: 200, child: Text('Saree Rolling'))),
                    DataCell(Container(width: 100, child: Text('FLAT 25% OFF'),)),
                  ]),
                  DataRow(cells: [
                    DataCell(Container(width: 200, child: Text('Shoe Cleaning'))),
                    DataCell(Container(width: 100, child: Text('FLAT 25% OFF'),)),
                  ]),
                  DataRow(cells: [
                    DataCell(Container(width: 200, child: Text('Stain Removal'))),
                    DataCell(Container(width: 100, child:Icon(Icons.check, color: Colors.green),)),
                  ]),

                  // Add more rows as needed
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),  // Change padding as needed
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'subscription_booking');
              },
              child: Text('Buy Now'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),  // Set your size
              ),
            ),
          )



        ]
      ),
    );
  }
}

/*
class BuyNowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green, // Background color
        onPrimary: Colors.white, // Text Color (Foreground color)
      ),
      onPressed: () {
        // Handle button press
        print('Buy Now button pressed');
        // Add your logic here
      },
      child: Text('Buy Now'),
    );
  }
}*/
