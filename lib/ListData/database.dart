import 'package:hive/hive.dart';

class DecListDataBase {
  List DecList = [];

  List DataList = [];

  List DateList = [];

  List EmoList = [];

  final _myBox = Hive.box('mybox');

  void defultList() {
    DecList = [
      ["Your Topic", false]
    ];

    DataList = [
      ["Your Diary"]
    ];

    DateList = [
      ["3/10/2023"]
    ];

    EmoList = [
      ["😄"]
    ];
  }

  void loadData() {
    DecList = _myBox.get("DECLIST");
    DataList = _myBox.get("DATALIST");
    DateList = _myBox.get("DATELIST");
    EmoList = _myBox.get("EMO");
  }

  void updateData() {
    _myBox.put("DECLIST", DecList);
    _myBox.put("DATALIST", DataList);
    _myBox.put("DATELIST", DateList);
    _myBox.put("EMO", EmoList);
  }
}
