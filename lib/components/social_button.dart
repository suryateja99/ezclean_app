
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget{
  const SocialButton({Key ?key, required this.social}) :super(key: key);

  final String social;
  @override
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        side: const BorderSide(width: 1, color: Colors.black),
      ),

    onPressed: (){}, child:
    SizedBox(
      width: screenWidth * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/$social.png',
          width: 40,
          height: 40,
          ),
          Text(
            social.toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
            ),
          )
        ],

      ),
    )
    );
  }
}