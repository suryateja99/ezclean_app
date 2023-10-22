import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/models.dart';
import '../utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List imageList = [
    {"id": 1, "image_path": 'assets/banner.png'},
    {"id": 2, "image_path": 'assets/bestsellersbanner.png'},
    {"id": 3, "image_path": 'assets/banner.png'},
  ];

  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "Our Services",
      "price": "\$55",
      "images": '',
      "icon": Icons.local_laundry_service,
    },
    {
      "title": "Pricing",
      "price": "\$55",
      "images": '',
      "icon":Icons.local_offer,
    },
    {
      "title": "Subscription",
      "price": "\$55",
      "images": '',
      "icon": Icons.star,
    },
    {
      "title": "Technology",
      "price": "\$55",
      "images": '',
      "icon" : Icons.computer,
    },
    {
      "title": "About Us",
      "price": "\$55",
      "images": '',
      "icon": Icons.info,
    },
    {
      "title": "Refer A friend",
      "price": "\$55",
      "images": '',
      "icon" : Icons.share,
    },
  ];


  final CarouselController carouselController = CarouselController();
  int current_index = 0;

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage, viewportFraction: 0.42);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  bool _isSpeedDialOpen = false;

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_isSpeedDialOpen)
            ...[
              FloatingActionButton(
                mini: true,
                onPressed: () {},
                heroTag: 'whatsapp',
                child: Icon(FontAwesomeIcons.whatsapp),
                backgroundColor: Colors.green,
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                mini: true,
                onPressed: () {},
                backgroundColor: Colors.blue,
                heroTag: 'phone',
                child: Icon(FontAwesomeIcons.phone),
              ),
              SizedBox(height: 10),
              FloatingActionButton(
                mini: true,
                onPressed: () {
                  Navigator.of(context).pushNamed('booking_page');
                },
                backgroundColor: Colors.blue,
                heroTag: 'calender',
                child: Icon(Icons.calendar_today),
              ),
              SizedBox(height: 10),
            ],
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                _isSpeedDialOpen = !_isSpeedDialOpen;
              });
            },
            label: Text(_isSpeedDialOpen ? 'Close' : 'Order Now'),
            icon: Icon(_isSpeedDialOpen ? Icons.close : Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Hi! kothagattuS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/logo.png'), //insert image here
                    ),
                  ],
                ),
                Config.spaceSmall,
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        print(current_index);
                      },
                      child: CarouselSlider(
                        items: imageList.map(
                              (item) => Image.asset(
                            item['image_path'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ).toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              current_index = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => carouselController.animateToPage(entry.key),
                            child: Container(
                              width: current_index == entry.key ? 17 : 7,
                              height: 7.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                color: current_index == entry.key ? Colors.red : Colors.teal,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
                Config.spaceSmall,
                const Text(
                  "Our Services",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Config.spaceSmall,
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    mainAxisExtent: 175,
                  ),
                  itemCount: gridMap.length,
                  itemBuilder: (_, index) {
                    final iconData = gridMap[index]["icon"] as IconData?;
                    final label = gridMap[index]["title"];
                    return GestureDetector(
                      onTap: () {
                        if (index ==0){
                          Navigator.pushNamed(context, 'our_services');
                        }else if (index == 1){
                          Navigator.pushNamed(context, 'pricing');
                        } else if (index ==2){
                          Navigator.pushNamed(context, 'Subscription');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.redAccent.shade100,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (iconData != null) // Check if there's an icon provided
                              Icon(
                                iconData, // Use the icon data to display the icon
                                size: 85,
                                color: Colors.white,
                              ),
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16, // Customize label font size
                        ),
                      ),
                          ],
                        ),

                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
