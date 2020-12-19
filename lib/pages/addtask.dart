import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/database.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/custom_datetime_picker.dart';
import 'package:todo_app/widgets/custommodel_action.dart';
import 'package:todo_app/widgets/customtxt_input.dart';

class AddTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddTaskState();
}

class AddTaskState extends State<AddTask> {
  DateTime selectedDate = DateTime.now();
  final _txtTaskController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Database>(context);
    _txtTaskController.clear();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            "Add New Task",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: 24,
          ),
          CustomTxtField(
            labelTxt: "Type in Your Task",
            controller: _txtTaskController,
          ),
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
          CustomActionButton(onCancel: () {
            Navigator.of(context).pop();
          }, onSave: () {
            if (_txtTaskController.text == "" ||
                _txtTaskController.text.isEmpty) {
              print("You should enter someting! :)");
            } else {
              provider
                  .insertTodoEntries(new TodoData(
                      id: null,
                      date: selectedDate,
                      time: DateTime.now(),
                      task: _txtTaskController.text,
                      description: "",
                      isDone: false,
                      todoType: TodoType.TYPE_TASK.index))
                  .whenComplete(() => Navigator.of(context).pop());
            }
          }),
        ],
      ),
    );
  }
}
