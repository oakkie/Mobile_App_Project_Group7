import 'package:Project2/app_screen/ClickedDiaryPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import '../calendar/cal2.dart';
import './write_diaryFix.dart';
import '/ListData/database.dart';
import 'Drawer.dart';
import 'Graph.dart';

class Scene extends StatefulWidget {
  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(243, 222, 186, 1),
        centerTitle: true,
        title: Text(
          'Your Diary',
          style: const TextStyle(
            color: Color.fromRGBO(71, 60, 51, 1),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(71, 60, 51, 1),
        ), // Change the icon color to white
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          color: Color.fromRGBO(169, 144, 126, 1),
          child: SlidCard(),
        ),
      ),
    );
  }
}

class SlidCard extends StatefulWidget {
  const SlidCard({Key? key}) : super(key: key);

  @override
  State<SlidCard> createState() => _SlidCardState();
}

class _SlidCardState extends State<SlidCard> {
  final _controller = TextEditingController();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _myBox = Hive.box('mybox');
  DecListDataBase db = DecListDataBase();

  void initState() {
    if (_myBox.get("DATALIST") != null) {
      db.loadData();
    } else {
      db.defultList();
    }
    super.initState();
  }

  /////////////////////////////graph
  List<double> weeklySummary = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  void _incrementSunAmount() {
    setState(() {
      weeklySummary[0] += 1;
    });
  }

  /////////////////////////////graph

  void saveNewTask() {
    setState(() {
      db.DecList.add([_controller.text, false]);
      _controller.clear();
      db.DataList.add([_controller1.text, false]);
      _controller1.clear();
      db.DateList.add([_controller2.text, false]);
      _controller2.clear();
      db.EmoList.add([_controller3.text, false]);
      _controller3.clear();
    });

    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return SecondScreen(
            controller: _controller,
            controller1: _controller1,
            controller2: _controller2,
            controller3: _controller3,
            onSave: saveNewTask,
            onBack: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.DecList.removeAt(index);
      db.DataList.removeAt(index);
      db.DateList.removeAt(index);
      db.EmoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Expanded(
            child: ListView.builder(
              itemCount: db.DecList.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Container(
                    child: Column(children: <Widget>[
                      InkWell(
                          onTap: () {
                            if (db.EmoList[index][0] == '😄') {
                              setState(() {
                                weeklySummary[0] += 1;
                              });
                            }
                            if (db.EmoList[index][0] == '😢') {
                              setState(() {
                                weeklySummary[1] += 1;
                              });
                            }
                            if (db.EmoList[index][0] == '😭') {
                              setState(() {
                                weeklySummary[2] += 1;
                              });
                            }
                            if (db.EmoList[index][0] == '😍') {
                              setState(() {
                                weeklySummary[3] += 1;
                              });
                            }
                            if (db.EmoList[index][0] == '😡') {
                              setState(() {
                                weeklySummary[4] += 1;
                              });
                            }
                            ;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Clickdiary(
                                      key: UniqueKey(),
                                      TaskName: db.DecList[index][0],
                                      DataInfo: db.DataList[index][0],
                                      Datetime: db.DateList[index][0],
                                      Emoji: db.EmoList[index][0],
                                      Check: db.DecList[index][1])),
                            );
                          },
                          child: _buildCard(
                              key: UniqueKey(),
                              TaskName: db.DecList[index][0],
                              DataInfo: db.DataList[index][0],
                              Datetime: db.DateList[index][0],
                              Check: db.DecList[index][1],
                              Emoji: db.EmoList[index][0],
                              deleteFuction: (context) => deleteTask(index))),
                    ]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: FloatingActionButton(
                child: const Icon(Icons.calendar_month),
                backgroundColor: Colors.black12,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventCalendarScreen()),
                  );
                },
                mini: true,
              ),
            ),
            Container(
              width: 100,
              margin: EdgeInsets.only(bottom: 30),
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                backgroundColor: Color.fromRGBO(71, 60, 51, 1),
                onPressed: createNewTask,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: FloatingActionButton(
                child: const Icon(Icons.person),
                backgroundColor: Colors.black12,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Graph(
                              ShowGraph: weeklySummary,
                              incrementSunAmount: _incrementSunAmount,
                            )),
                  );
                },
                mini: true,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class _buildCard extends StatelessWidget {
  final String TaskName;
  final String DataInfo;
  final String Datetime;
  final String Emoji;
  final bool Check;
  Function(BuildContext)? deleteFuction;

  _buildCard({
    required this.TaskName,
    required this.DataInfo,
    required this.Datetime,
    required this.deleteFuction,
    required this.Emoji,
    required Key key,
    required this.Check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFuction,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(15),
            )
          ],
        ),
        child: SizedBox(
          child: Card(
            child: Expanded(
              child: Container(
                width: 800,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(
                            TaskName,
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            Emoji,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        DataInfo,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        Datetime,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}

class addGraphButton extends ElevatedButton {
  final VoidCallback onPressed;
  final String text;
  final VoidCallback? onIncrementSunAmount;

  addGraphButton({
    required this.onPressed,
    required this.text,
    this.onIncrementSunAmount,
  }) : super(
          onPressed: onPressed,
          child: Text(text),
        );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onIncrementSunAmount != null
          ? () {
              onIncrementSunAmount!();
              onPressed();
            }
          : onPressed,
      child: Text(text),
    );
  }
}
