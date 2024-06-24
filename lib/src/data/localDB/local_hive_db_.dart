import 'package:hive_flutter/hive_flutter.dart';



class LocalDb{

  List toDoList = [];

  final _Box = Hive.box('A Box');

  //create 
  void CreateData(){
    toDoList = [];
  }

  //load data
  void loadData(){
    toDoList = _Box.get("toDoList");
  }

  //update the database
  void updatedata(){
    _Box.put("toDoList", toDoList);
  }
}