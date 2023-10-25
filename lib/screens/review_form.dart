import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewForm extends StatelessWidget {
  final String selectedService;
  final String name;
  final String phoneNumber;
  final String houseNumber;
  final String street;
  final String city;
  final String pincode;
  final DateTime selectedDate;
  final String selectedTime;

  ReviewForm({
    Key? key,
    required this.selectedService,
    required this.name,
    required this.phoneNumber,
    required this.houseNumber,
    required this.street,
    required this.city,
    required this.pincode,
    required this.selectedDate,
    required this.selectedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Selected Service'),
          subtitle: Text(selectedService),
        ),
        ListTile(
          title: Text('Name'),
          subtitle: Text(name),
        ),
        ListTile(
          title: Text('Phone Number'),
          subtitle: Text(phoneNumber),
        ),
        ListTile(
          title: Text('House Number'),
          subtitle: Text(houseNumber),
        ),
        ListTile(
          title: Text('Street'),
          subtitle: Text(street),
        ),
        ListTile(
          title: Text('City'),
          subtitle: Text(city),
        ),
        ListTile(
          title: Text('Pincode'),
          subtitle: Text(pincode),
        ),
        ListTile(
          title: Text('Selected Date'),
          subtitle: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
        ),
        ListTile(
          title: Text('Selected Time'),
          subtitle: Text(selectedTime),
        ),
      ],
    );
  }
}
