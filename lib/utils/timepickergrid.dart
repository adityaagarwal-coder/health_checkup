import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TimePickerGrid extends StatefulWidget {
  final Function(String) onTimeSelected;

  TimePickerGrid({required this.onTimeSelected});
  @override
  State<TimePickerGrid> createState() => _TimePickerGridState();
}

class _TimePickerGridState extends State<TimePickerGrid> {
  int selectedTimeIndex = -1;

  final List<String> timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // You can adjust the number of columns as needed
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: timeSlots.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            // Handle time selection here
            setState(() {
              selectedTimeIndex = index;
            });
            String selectedTime = timeSlots[index];
            print('Selected Time: $selectedTime');
            widget.onTimeSelected(selectedTime);
          },
          child: Container(
            width: 10,
            height: 6,
            decoration: BoxDecoration(
              color: selectedTimeIndex == index
                  ? HexColor('#10217D')
                  : Colors.white,
              border: Border.all(color: HexColor('#10217D')),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Text(
                timeSlots[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: selectedTimeIndex == index
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
