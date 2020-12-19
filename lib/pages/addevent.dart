import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/widgets/custom_datetime_picker.dart';
import 'package:todo_app/widgets/custommodel_action.dart';
import 'package:todo_app/widgets/customtxt_input.dart';

class AddEvent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddEventState();
}

class AddEventState extends State<AddEvent> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = "Pick up the time";

  Future _pickDate() async {
    DateTime datePick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datePick != null) {
      setState(() {
        selectedDate = datePick;
      });
    }
  }

  Future _pickTime() async {
    TimeOfDay timePick = await showTimePicker(
        context: context, initialTime: new TimeOfDay.now());
    if (timePick != null) {
      setState(() {
        selectedTime = timePick.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            "Add New Event",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: 24,
          ),
          CustomTxtField(labelTxt: "Type in Your Event"),
          SizedBox(
            height: 12,
          ),
          CustomTxtField(labelTxt: "Add Description"),
          SizedBox(
            height: 12,
          ),
          CustomDateTimePicker(
              onPressed: _pickDate,
              icon: Icons.date_range,
              value: new DateFormat("dd-MM-yyyy").format(selectedDate)),
          CustomDateTimePicker(
              onPressed: _pickTime,
              icon: Icons.access_time,
              value: selectedTime),
          SizedBox(
            height: 24,
          ),
          CustomActionButton(
              onCancel: () {
                Navigator.of(context).pop();
              },
              onSave: () {}),
        ],
      ),
    );
  }
}
