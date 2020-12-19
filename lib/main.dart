import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/database.dart';
import 'package:todo_app/pages/addevent.dart';
import 'package:todo_app/pages/addtask.dart';
import 'package:todo_app/pages/events.dart';
import 'package:todo_app/pages/tasks.dart';
import 'package:todo_app/widgets/custombtn.dart';
// import 'package:todo_app/pages/tasks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<Database>(create: (_) => Database())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController();
  double currentActivity = 0;
  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentActivity = _pageController.page;
      });
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 35,
            color: Theme.of(context).accentColor,
          ),
          Positioned(
            right: 0,
            child: Text(
              "8",
              style: TextStyle(fontSize: 200, color: Colors.black12),
            ),
          ),
          mainContent(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    child: currentActivity == 0 ? AddTask() : AddEvent(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))));
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "Wednesday",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _button(context),
        ),
        Expanded(
            child: PageView(
          controller: _pageController,
          children: <Widget>[Tasks(), Events()],
        )),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomBtn(
            onPressed: () {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceInOut);
            },
            btnTxt: "Tasks",
            color: currentActivity < 0.5
                ? Theme.of(context).accentColor
                : Colors.white,
            txtColor: currentActivity < 0.5
                ? Colors.white
                : Theme.of(context).accentColor,
            borderColor: currentActivity < 0.5
                ? Colors.transparent
                : Theme.of(context).accentColor,
          ),
        ),
        SizedBox(
          width: 32,
        ),
        Expanded(
          child: CustomBtn(
            onPressed: () {
              _pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceInOut);
            },
            btnTxt: "Events",
            color: currentActivity > 0.5
                ? Theme.of(context).accentColor
                : Colors.white,
            txtColor: currentActivity > 0.5
                ? Colors.white
                : Theme.of(context).accentColor,
            borderColor: currentActivity > 0.5
                ? Colors.transparent
                : Theme.of(context).accentColor,
          ),
        ),
        SizedBox(
          width: 32,
        ),
      ],
    );
  }
}
