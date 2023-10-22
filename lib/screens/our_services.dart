import 'package:flutter/material.dart';

class OurServices extends StatefulWidget{
  const OurServices ({Key? key}) : super(key: key);

  @override
  State<OurServices> createState() => _OurServices();
}

class _OurServices extends State<OurServices> {
  @override
  Widget build(BuildContext context){
    return Center(
      child: Text("our services "),
    );
  }
}