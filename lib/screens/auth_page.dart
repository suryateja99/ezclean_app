
import 'package:flutter/material.dart';

import '../components/login_form.dart';
import '../components/social_button.dart';
import '../utils/config.dart';
import '../utils/text.dart';

class AuthPage extends StatefulWidget{
  const AuthPage({Key? key}) : super(key : key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}


class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        AppText.enText['welcome_text']!,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width:  screenWidth* 0.3,
                  ),
                  Column(
                    children: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pushNamed('main');
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black
                      ), child: const Text('Skip'
                      ),)
                    ],
                  )
                ],
              ),

              Config.spaceSmall,
              Text(
                AppText.enText['signIn_text']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              const LoginForm(),
              Config.spaceSmall,
              Center(
                child: TextButton(
                  onPressed: (){},
                  child: Text(
                    AppText.enText['forgot_password']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  AppText.enText['social_login']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade500
                  ),
                ),
              ),
              Config.spaceSmall,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [
                  Expanded(child: SocialButton(social: 'google')),
                  Expanded(child: SocialButton(social: 'facebook')),
                ],
              ),
              Config.spaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text(
                    AppText.enText['signUp_text']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const Text('Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}