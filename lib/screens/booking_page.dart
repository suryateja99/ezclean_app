import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/button.dart';
import '../components/custom_appbar.dart';
import '../utils/config.dart';

class BookingPage extends StatefulWidget{
  const BookingPage ({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay  = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  List<int> getAvailableTimes() {
    final now = DateTime.now();
    if (_currentDay.day == now.day &&
        _currentDay.month == now.month &&
        _currentDay.year == now.year) {
      return List.generate(11, (index) => index + 9)
          .where((time) => time > now.hour)
          .toList();
    }
    return List.generate(11, (index) => index + 9);
  }

  @override
  Widget build(BuildContext context){
    Config().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Appointment',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                  _tableCalendar(),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Center(
                    child: Text('Select Pickup Time on any day',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),)

                  ),
                ),
              ],
            ),
          ),
          _isWeekend ? SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index){
              return InkWell(
                splashColor: Colors.transparent,
                onTap: (){
                  setState(() {
                    _currentIndex = index;
                    _timeSelected = true;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _currentIndex == index ? Colors.white : Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: _currentIndex == index ? Config.primaryColor : null,
                  ),
                  alignment: Alignment.center,
                  child: Text('${getAvailableTimes()[index]}:00 ${getAvailableTimes()[index] > 11 ? "PM" : "AM"}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _currentIndex ==index ? Colors.white : null,
                    ),
                  ),
                ),
              );
            },
              childCount: getAvailableTimes().length,

            )
            , gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1.5),)  : SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index){
              return InkWell(
                splashColor: Colors.transparent,
                onTap: (){
                  setState(() {
                    _currentIndex = index;
                    _timeSelected = true;
                  });
                },
              child: Container(
              margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _currentIndex == index ? Colors.white : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: _currentIndex == index ? Config.primaryColor : null,
                ),
                alignment: Alignment.center,
                child: Text('${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _currentIndex ==index ? Colors.white : null,
                ),
                ),
              ),
              );
            },
            childCount: 11,
            )
            , gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1.5),),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Button(
                width: double.infinity,
                title: 'Book Appointment',
                onPressed: (){},
                disable: _timeSelected && _dateSelected ? false : true,
              ),
            ),
          )
        ]
      ),
    );
  }
  Widget _tableCalendar(){
    return TableCalendar(focusedDay: _focusDay, firstDay: DateTime.now(), lastDay: DateTime(2023,12,31),
    calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(color: Config.primaryColor, shape: BoxShape.circle),
        ),
      availableCalendarFormats: const{
      CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format){
      setState(() {
        _format = format;
      });
      },
      onDaySelected: ((selectedDay, focusedDay){
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          if (selectedDay.weekday ==6 || selectedDay.weekday ==7){
            _isWeekend = true;
            _timeSelected = true;

          }else{
            _isWeekend = true;
          }
        });
      }),
    );

  }
}