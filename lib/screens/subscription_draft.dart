import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/custom_appbar.dart';

class SubscriptionDraft extends StatefulWidget{
  const SubscriptionDraft ({Key? key}) : super(key: key);

  @override
  State<SubscriptionDraft> createState() => _SubscriptionDraft();
}

class _SubscriptionDraft extends State<SubscriptionDraft> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Subscription Plan',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: CenterImageLarger(),


    );
  }
}

    class CenterImageLarger extends StatelessWidget {
      final List<String> imagePaths = [
        'assets/banner.png',
        'assets/best.png',
        'assets/dryclean.jpg',
      ];

      @override
      Widget build(BuildContext context) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imagePaths.asMap().entries.map((entry) {
              final index = entry.key;
              final imagePath = entry.value;
              final isCenterImage = index == 1;
              double width = isCenterImage ? 150.0 : 100.0;
              double height = isCenterImage ? 150.0 : 100.0;
              EdgeInsets margin = isCenterImage
                  ? EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0)
                  : EdgeInsets.symmetric(horizontal: 5.0);
              return Container(
                margin: margin,
                width: width +15,
                height: height + 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }
}