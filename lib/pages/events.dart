import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_icondecoration.dart';

class Events extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EventState();
}

class Event {
  final String time;
  final String task;
  final String desc;
  final bool isDone;

  const Event(this.time, this.task, this.desc, this.isDone);
}

final List<Event> _eventlist = [
  new Event("08:00", "Have Coffee with Walaa", "Family", true),
  new Event("10:00", "Have video call with family", "Family", true),
  new Event("12:00", "Start chat app!", "Work", true),
  new Event("14:00", "Paint the 15*15 canvas", "Personal", false),
  new Event("16:00", "Have online session for UbiComputing", "College", false),
  new Event("18;00", "Finsh studying chapters..", "College", false),
];

class EventState extends State<Events> {
  double iconSize = 20;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _eventlist.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Row(
            children: <Widget>[
              _lineStyle(context, iconSize, index, _eventlist.length,
                  _eventlist[index].isDone),
              _displayTime(_eventlist[index].time),
              _displayContent(_eventlist[index]),
            ],
          ),
        );
      },
    );
  }

  Expanded _displayContent(Event event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x20000000),
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(event.task),
                SizedBox(
                  height: 12,
                ),
                Text(event.desc),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _displayTime(String time) {
    return Container(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(time),
        ));
  }

  Container _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isDone) {
    return Container(
        decoration: CustomIconDecoration(
            iconSize: iconSize,
            firstDate: index == 0 ?? true,
            lastDate: index == listLength - 1 ?? true,
            lineWidth: 1),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3),
                    color: Color(0x20000000),
                    blurRadius: 5)
              ]),
          child: Icon(
            isDone ? Icons.fiber_manual_record : Icons.radio_button_unchecked,
            size: 20,
            color: Theme.of(context).accentColor,
          ),
        ));
  }
}
