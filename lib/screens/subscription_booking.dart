import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/button.dart';
import '../components/custom_appbar.dart';
import '../utils/config.dart';

class SubscriptionBooking extends StatefulWidget{
  const SubscriptionBooking ({Key? key}) : super(key: key);

  @override
  State<SubscriptionBooking> createState() => _SubscriptionBookingState();
}

class _SubscriptionBookingState extends State<SubscriptionBooking> {
  static const int totalSteps = 4;
  int? selectedSlotIndex;
  int? selectedSlotIndex2;
  int? selectedSlotIndex3;

  int currentStep = 0;
  /*void continueStep() {
    if (currentStep < totalSteps - 1) {
      if (currentStep == 1 || currentStep == 2 || currentStep == 3) {
        if (selectedSlotIndex != null) { // Check if a time slot is selected
          setState(() {
            currentStep = currentStep + 1;
          });
        } else {
          // Show an error message or handle the case when no time slot is selected
        }
      } else if (currentStep < 3) {
        setState(() {
          currentStep = currentStep + 1;
        });
      }
    }
  }*/
   continueStep() {
    if (currentStep < totalSteps - 1) {
      if (currentStep == 1 && selectedSlotIndex != null) {
        setState(() {
          currentStep = currentStep + 1;
        });
      } else if (currentStep == 2 && selectedSlotIndex2 != null) {
        setState(() {
          currentStep = currentStep + 1;
        });
      } else if (currentStep == 3 && selectedSlotIndex3 != null) {
        setState(() {
          currentStep = currentStep + 1;
        });
      } else if (currentStep < 3) {
        setState(() {
          currentStep = currentStep + 1;
        });
      } else {
        // Handle the case when no time slot is selected
      }
    }
  }



  cancelStep(){
    if (currentStep >0){
      setState(() {
        currentStep = currentStep -1;

      });
    }
  }

  onStepTapped(int value){
    setState(() {
      currentStep = value;
    });

  }
  Widget controlsBuilder(BuildContext context, ControlsDetails details) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: (currentStep == 0 && !isAtleastOneCheckBoxSelected()) ? null : /*(currentStep == 1 && !isFormValid()) ? null :*/ details.onStepContinue,
            child: Text('Next')
        ),
        const SizedBox(width: 10,),
        OutlinedButton(onPressed: details.onStepCancel, child: const Text('Back'))
      ],
    );
  }


  bool isAtleastOneCheckBoxSelected(){
    return isCheckedWashIron || isCheckedWashFold || isCheckedDryClean || isCheckedShoe || isCheckedSaree || isCheckedPremium;
  }
  bool isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();
  DateTime _focusedDay2 = DateTime.now();
  DateTime _selectedDate3 = DateTime.now();
  DateTime _focusedDay3 = DateTime.now();


  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
  String formatHour(int hour) {
    if (hour == 0) return '12am';
    if (hour == 12) return '12pm';
    if (hour > 12) return '${hour - 12}pm';
    return '${hour}am';
  }

  List<String> generateTimeSlots(DateTime selectedDate) {
    final now = DateTime.now();
    final List<String> slots = [];
    final startHour = isSameDay(selectedDate, now) ? now.hour + 1 : 9; // Assuming 9 AM as the starting hour

    for (int hour = startHour; hour <= 21; hour++) { // Assuming 9 PM as the ending hour
      final start = formatHour(hour);
      final end = formatHour(hour + 2);
      slots.add('$start-$end');
    }

    return slots;
  }





  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  bool isCheckedWashIron = false;
  bool isCheckedWashFold = false;
  bool isCheckedDryClean = false;
  bool isCheckedShoe = false;
  bool isCheckedSaree = false;
  bool isCheckedPremium = false;



  @override
  Widget build(BuildContext context){
    Config().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Subscribe Now',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: Stepper(
        currentStep: currentStep ,
        onStepContinue: continueStep,
        onStepCancel: cancelStep,
        onStepTapped: onStepTapped,
        controlsBuilder: controlsBuilder,

        steps: [
          Step(
            title: const Text('Step 1'),
            content: Center(
              child:Theme(data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Colors.red
              ), child: Column(
                children: [
                  CheckboxListTile(

                    title: Text('Wash and Iron'),
                    value: isCheckedWashIron,
                    secondary: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/washandiron.jpg', fit: BoxFit.cover,),
                    ),
                    onChanged: (value){
                      setState(() => isCheckedWashIron = value!
                      );
                    },
                  ),
                  /*CheckboxListTile(

                    title: Text('Wash and Fold'),
                    value: isCheckedWashFold,
                    secondary: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/washandfold.jpeg', fit: BoxFit.cover,),
                    ),
                    onChanged: (value){
                      setState(() => isCheckedWashFold = value!
                      );
                    },
                  ),
                  CheckboxListTile(

                    title: Text('Dry Cleaning'),
                    value: isCheckedDryClean,
                    secondary: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/dryclean.jpg', fit: BoxFit.cover,),
                    ),
                    onChanged: (value){
                      setState(() => isCheckedDryClean = value!
                      );
                    },
                  ),
                  CheckboxListTile(

                    title: Text('Saree Rolling'),
                    value: isCheckedSaree,
                    secondary: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/saree.webp', fit: BoxFit.cover,),
                    ),
                    onChanged: (value){
                      setState(() => isCheckedSaree = value!
                      );
                    },
                  ),
                  CheckboxListTile(

                    title: Text('Shoe Cleaning'),
                    secondary: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/shoe.webp', fit: BoxFit.cover,),
                    ),
                    value: isCheckedShoe,
                    onChanged: (value){
                      setState(() => isCheckedShoe = value!
                      );
                    },
                  ),
                  CheckboxListTile(

                    title: Text('Premium Laundry'),
                    value: isCheckedPremium,
                    secondary: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/premium.jpg', fit: BoxFit.cover,),
                    ),
                    onChanged: (value){
                      setState(() => isCheckedPremium = value!
                      );
                    },
                  ),*/
                ],
              ),
              ),

            ),
            isActive: currentStep >= 0,
            state: isAtleastOneCheckBoxSelected() ? StepState.complete: StepState.disabled,
          ),
          Step(title: Text('Step 2'),
            content:
            Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),  // Adjust this to your desired start date
                  lastDay: DateTime.utc(2030, 12, 31), // Adjust this to your desired end date
                  focusedDay: _focusedDay2,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDate2, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate2 = selectedDay;
                      _focusedDay2 = focusedDay;
                      selectedSlotIndex = null;// update the focusedDay
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Config.primaryColor, // Change this to your desired color
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.grey, // Color for today's date
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // Here, you can add the time slots based on the selected day.
                // For simplicity, I'm just showing the slots without any conditions.
                Wrap(
                  spacing: 10.0,
                  children: generateTimeSlots(_selectedDate2).asMap().entries.map((entry) {
                    int idx = entry.key;
                    String slot = entry.value;
                    return ChoiceChip(
                      label: Text(slot),
                      selected: idx == selectedSlotIndex2, // You can manage the selection state with a variable
                      onSelected: (selected) {
                        setState(() {
                          selectedSlotIndex2 = idx;
                        });
                      },
                      backgroundColor: Colors.grey[300],
                      selectedColor: Config.primaryColor,
                      labelStyle: TextStyle(
                        color: idx == selectedSlotIndex ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),/*Container(
              margin: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    *//*TextFormField(
                      decoration: InputDecoration(labelText: "Enter your Name"),
                      validator: (value){
                        if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                          return 'Enter your Name';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: Config.screenHeight! * 0.01,),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Enter your Phone Number"),
                      validator: (value){
                        if(value!.isEmpty || !RegExp(r'^[+]*[(]{0,1}[0-9{1,4}[)]{0,1}[-\s\./0-9]+$').hasMatch(value)){
                          return 'Enter Phone Number';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: Config.screenHeight! * 0.01,),
                    TextFormField(
                      decoration: InputDecoration(labelText: "House Number"),
                      validator: (value){
                        if(value!.isEmpty ){
                          return 'Enter House Number';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: Config.screenHeight! * 0.01,),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Street"),
                      validator: (value){
                        if(value!.isEmpty ){
                          return 'Enter Street Name';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: Config.screenHeight! * 0.01,),
                    TextFormField(
                      decoration: InputDecoration(labelText: "City"),
                      validator: (value){
                        if(value!.isEmpty ){
                          return 'Enter City Name';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: Config.screenHeight! * 0.01,),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Pincode"),
                      validator: (value){
                        if(value!.isEmpty ){
                          return 'Enter Pin code';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: Config.screenHeight! * 0.01,),*//*




                  ],
                ),
              ),
            ),*/
            isActive: currentStep >= 1,
            state: currentStep >=1 ? StepState.complete: StepState.disabled,
          ),

          Step(
            title: Text('Step 3'),
            content: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),  // Adjust this to your desired start date
                  lastDay: DateTime.utc(2030, 12, 31), // Adjust this to your desired end date
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                      _focusedDay = focusedDay;
                      selectedSlotIndex = null;// update the focusedDay
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Config.primaryColor, // Change this to your desired color
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.grey, // Color for today's date
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // Here, you can add the time slots based on the selected day.
                // For simplicity, I'm just showing the slots without any conditions.
                Wrap(
                  spacing: 10.0,
                  children: generateTimeSlots(_selectedDate).asMap().entries.map((entry) {
                    int idx = entry.key;
                    String slot = entry.value;
                    return ChoiceChip(
                      label: Text(slot),
                      selected: idx == selectedSlotIndex, // You can manage the selection state with a variable
                      onSelected: (selected) {
                        setState(() {
                          selectedSlotIndex = idx;
                        });
                      },
                      backgroundColor: Colors.grey[300],
                      selectedColor: Config.primaryColor,
                      labelStyle: TextStyle(
                        color: idx == selectedSlotIndex ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            isActive: currentStep >= 2,
            state: currentStep >= 2 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: Text('Step 4'),
            content: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),  // Adjust this to your desired start date
                  lastDay: DateTime.utc(2030, 12, 31), // Adjust this to your desired end date
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                      _focusedDay = focusedDay;
                      selectedSlotIndex = null;// update the focusedDay
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Config.primaryColor, // Change this to your desired color
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.grey, // Color for today's date
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // Here, you can add the time slots based on the selected day.
                // For simplicity, I'm just showing the slots without any conditions.
                Wrap(
                  spacing: 10.0,
                  children: generateTimeSlots(_selectedDate).asMap().entries.map((entry) {
                    int idx = entry.key;
                    String slot = entry.value;
                    return ChoiceChip(
                      label: Text(slot),
                      selected: idx == selectedSlotIndex, // You can manage the selection state with a variable
                      onSelected: (selected) {
                        setState(() {
                          selectedSlotIndex = idx;
                        });
                      },
                      backgroundColor: Colors.grey[300],
                      selectedColor: Config.primaryColor,
                      labelStyle: TextStyle(
                        color: idx == selectedSlotIndex ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            isActive: currentStep >= 2,
            state: currentStep >= 2 ? StepState.complete : StepState.disabled,
          ),


        ],
      ),


    );
  }
}