import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/database.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/custombtn.dart';

class Tasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TasksState();
}

class TasksState extends State<Tasks> {
  Database provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Database>(context);
    return StreamProvider.value(
      value: provider.getTodoByType(TodoType.TYPE_TASK.index),
      child: Consumer<List<TodoData>>(
        builder: (context, _datalist, child) {
          return _datalist == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: _datalist.length,
                  itemBuilder: (context, index) {
                    return _datalist[index].isDone
                        ? _taskCompleted(_datalist[index])
                        : _taskIncomplete(_datalist[index]);
                  },
                );
        },
      ),
    );
  }

  Widget _taskIncomplete(TodoData data) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Confirm Task Completion",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(
                      height: 24,
                    ),
                    Text(data.task),
                    SizedBox(
                      height: 24,
                    ),
                    Text(new DateFormat("dd-MM-yyyy").format(data.date)),
                    SizedBox(
                      height: 24,
                    ),
                    CustomBtn(
                      onPressed: () {
                        Database()
                            .completeTodoEntries(data.id)
                            .whenComplete(() => Navigator.of(context).pop());
                      },
                      btnTxt: "Complete",
                      color: Theme.of(context).accentColor,
                      txtColor: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Delete Task",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(
                      height: 24,
                    ),
                    Text(data.task),
                    SizedBox(
                      height: 24,
                    ),
                    Text(new DateFormat("dd-MM-yyyy").format(data.date)),
                    SizedBox(
                      height: 24,
                    ),
                    CustomBtn(
                      onPressed: () {
                        Database()
                            .deleteTodoEntries(data.id)
                            .whenComplete(() => Navigator.of(context).pop());
                      },
                      btnTxt: "Delete",
                      color: Theme.of(context).accentColor,
                      txtColor: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_unchecked,
              color: Theme.of(context).accentColor,
              size: 20,
            ),
            SizedBox(
              width: 28,
            ),
            Text(data.task)
          ],
        ),
      ),
    );
  }

  Widget _taskCompleted(TodoData data) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_checked,
              color: Theme.of(context).accentColor,
              size: 20,
            ),
            SizedBox(
              width: 28,
            ),
            Text(data.task)
          ],
        ),
      ),
    );
  }
}
