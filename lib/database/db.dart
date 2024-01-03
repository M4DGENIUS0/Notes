import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class notes {
  // open box
  final _mynotes = Hive.box('Notes');
  List Todolist = [];

  // create this method for 1st time of openning a program
  void createinitialdata() {
    Todolist = [];
  }

  // load data from db
  void loaddata() {
    Todolist = _mynotes.get("TODOLIST");
  }

  // update data from db
  void updatedata() {
    _mynotes.put("TODOLIST", Todolist);
  }
}
