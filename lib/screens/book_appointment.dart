import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:health_checkup/screens/mycart.dart';
import 'package:health_checkup/utils/timepickergrid.dart';
import 'package:hexcolor/hexcolor.dart';

List<DateTime?> _singleDatePickerValueWithDefaultValue = [
  DateTime.now(),
];

class BookAppointment extends StatefulWidget {
  Function(List<DateTime?>, String) onConfirm;
  BookAppointment(this.onConfirm);
  // const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  String selectedTime = '';
  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    return valueText;
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: HexColor('#10217D'),
      weekdayLabels: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
      weekdayLabelTextStyle: const TextStyle(
          color: Color(0xFF808080), fontWeight: FontWeight.w500, fontSize: 12),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Color(0xFF303030),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      // dayTextStyle: const TextStyle(
      //   color: Colors.amber,
      //   fontWeight: FontWeight.bold,
      // ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            'Select Date',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Card(
            child: CalendarDatePicker2(
              config: config,
              value: _singleDatePickerValueWithDefaultValue,
              onValueChanged: (dates) => setState(
                  () => _singleDatePickerValueWithDefaultValue = dates),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     const Text('Selection(s):  '),
        //     const SizedBox(width: 10),
        //     Text(
        //       _getValueText(
        //         config.calendarType,
        //         _singleDatePickerValueWithDefaultValue,
        //       ),
        //     ),
        //   ],
        // ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            'Select Time',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Book Appointment",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: Column(
            children: [
              _buildDefaultSingleDatePickerWithValue(),
              Expanded(child: TimePickerGrid(
                onTimeSelected: (time) {
                  setState(() {
                    selectedTime = time;
                  });
                },
              )),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  widget.onConfirm(
                      _singleDatePickerValueWithDefaultValue, selectedTime);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: HexColor('#10217D'),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
