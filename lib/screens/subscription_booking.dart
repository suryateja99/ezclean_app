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
  List<String> days = [
    'Mon-Wed-Fri',
    'Tue-Thu-Sat',
    // Add more schedule options as needed
  ];

  List<String> timeSlots = [
    '9:00 AM - 11:00 AM',
    '11:00 AM - 1:00 PM',
    '2:00 PM - 4:00 PM',
    // Add more time slot options as needed
  ];

  int? selectedDayIndex;
  int? selectedTimeSlotIndex;
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

                ],
              ),
              ),

            ),
            isActive: currentStep >= 0,
            state: isAtleastOneCheckBoxSelected() ? StepState.complete: StepState.disabled,
          ),


          Step(
            title: const Text('Step 2'),
            content: Column(
              children: [
                Text('Select a day schedule:'),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List<Widget>.generate(
                    days.length,
                        (int index) {
                      return ChoiceChip(
                        label: Text(days[index]),
                        selected: index == selectedDayIndex,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedDayIndex = selected ? index : null;
                          });
                        },
                      );
                    },
                  ),
                ),
                Text('Select a time slot for your schedule:'),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List<Widget>.generate(
                    timeSlots.length,
                        (int index) {
                      return ChoiceChip(
                        label: Text(timeSlots[index]),
                        selected: index == selectedTimeSlotIndex,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedTimeSlotIndex = selected ? index : null;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            isActive: currentStep == 0,
            state: (selectedDayIndex != null && selectedTimeSlotIndex != null) ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Step 3'),
            content: Column(
              children: [
                Text('Select a day schedule:'),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List<Widget>.generate(
                    days.length,
                        (int index) {
                      return ChoiceChip(
                        label: Text(days[index]),
                        selected: index == selectedDayIndex,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedDayIndex = selected ? index : null;
                          });
                        },
                      );
                    },
                  ),
                ),
                Text('Select a time slot for your schedule:'),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List<Widget>.generate(
                    timeSlots.length,
                        (int index) {
                      return ChoiceChip(
                        label: Text(timeSlots[index]),
                        selected: index == selectedTimeSlotIndex,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedTimeSlotIndex = selected ? index : null;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            isActive: currentStep == 0,
            state: (selectedDayIndex != null && selectedTimeSlotIndex != null) ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Step 4'),
            content: Column(
              children: [
                Text('Select a day schedule:'),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List<Widget>.generate(
                    days.length,
                        (int index) {
                      return ChoiceChip(
                        label: Text(days[index]),
                        selected: index == selectedDayIndex,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedDayIndex = selected ? index : null;
                          });
                        },
                      );
                    },
                  ),
                ),
                Text('Select a time slot for your schedule:'),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List<Widget>.generate(
                    timeSlots.length,
                        (int index) {
                      return ChoiceChip(
                        label: Text(timeSlots[index]),
                        selected: index == selectedTimeSlotIndex,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedTimeSlotIndex = selected ? index : null;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            isActive: currentStep == 0,
            state: (selectedDayIndex != null && selectedTimeSlotIndex != null) ? StepState.complete : StepState.indexed,
          ),



        ],
      ),


    );
  }
}