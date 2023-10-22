import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/custom_appbar.dart';

class Pricing extends StatefulWidget {
  const Pricing({Key? key}) : super(key: key);

  @override
  State<Pricing> createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  final List<Map<String, dynamic>> items = [
    {
      "title": 'Wash and Iron',
      "content": 'Priced per kg',
      "expansionTexts": ['Rs 109/- per kg'],
    },
    {
      "title": 'Dry cleaning',
      "content": 'Priced Per Piece',
      "expansionTexts": ['Shirt - Rs 40/-', 'Pant - Rs 50/-', 'Saree - Rs 80/-'],
    },
    {
      "title": 'Saree Rolling',
      "content": 'Priced Per Piece',
      "expansionTexts": ['Cotton Saree - Rs 50', 'Silk Saree - Rs 80/-'],
    },
    {
      "title": 'Premium Laundy',
      "content": 'Priced per kg',
      "expansionTexts": ['Rs 149/- per kg'],
    },
    {
      "title": 'Wash and Fold',
      "content": 'Priced per kg',
      "expansionTexts": ['Rs 60/- per kg'],
    },
    {
      "title": 'Iron',
      "content": 'Priced per Piece',
      "expansionTexts": ['Shirt - Rs 30/-', 'Pant - Rs 40/-', 'Saree - Rs 60/-'],
    },
    {
      "title": 'Shoe Cleaning',
      "content": 'Priced per Piece',
      "expansionTexts": ['Leather shoe - Rs 250/-', 'Sneakers - Rs 300/-', 'Sandles - Rs 150/-'],
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Our Pricing',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: ListView(
        children: items.map((item) {
          return DropDownItem(
            title: item['title']!,
            content: item['content']!,
            expansionTexts : item['expansionTexts']!,
          );
        }).toList(),
      ),
    );
  }
}

class DropDownItem extends StatefulWidget {
  final String title;
  final String content;
  final List<String> expansionTexts;

  DropDownItem({required this.title, required this.content,required this.expansionTexts});

  @override
  _DropDownItemState createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 2.0,
      shadowColor: Colors.grey,
      child: Column(
        children: <Widget>[
          ExpansionTile(
            title: Text(widget.title,
              style: TextStyle(color: Colors.black),),
            onExpansionChanged: (value) {
              setState(() {
                isExpanded = value;
              });
            },
            children: <Widget>[
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.content,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              if (isExpanded)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.expansionTexts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(widget.expansionTexts[index]),
                      // You can add onTap handling for each option here
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

