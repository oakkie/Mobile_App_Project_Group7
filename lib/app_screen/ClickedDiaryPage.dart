import 'package:flutter/material.dart';

class Clickdiary extends StatelessWidget {
  final String TaskName;
  final String DataInfo;
  final String Datetime;
  final String Emoji;
  final bool Check;

  const Clickdiary({
    required this.Datetime,
    required this.TaskName,
    required this.DataInfo,
    required Key key,
    required this.Check,
    required this.Emoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(243, 222, 186, 1),
        centerTitle: true,
        title: Text(
          Datetime,
          style: const TextStyle(
            color: Color.fromRGBO(71, 60, 51, 1),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(71, 60, 51, 1),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  color: Colors.white,
                  child: Text(
                    TaskName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Spacer(),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(
                    Emoji,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
              color: Colors.white,
              child: Text(
                DataInfo,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
