import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/src/data/localDB/local_hive_db_.dart';
import 'package:todo/src/presentation/views/dialoge_box.dart';
import 'package:todo/src/presentation/widgets/todo_tile.dart';
import 'package:todo/src/utlis/constant/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //reference a box
  final _Box = Hive.box('A Box');
  LocalDb db = LocalDb();

  @override
  void initState() {
    if(_Box.get('toDoList')==null){
     db.CreateData();
    }else{
      db.loadData();
    }
    super.initState();
  }

  
  //text controller

  final _taskController = TextEditingController();
  final _contentController = TextEditingController();
  
 

  //checkbox was tapped
  void CheckboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][2] = value;
    });
    db.updatedata();
  }

  //saved NewTask
void savedNewTask(){
  setState(() {
    db.toDoList.add([_taskController.text, _contentController.text,false]);
    _taskController.clear();
    _contentController.clear();
  });
  db.updatedata();
  Get.back();
}

  // create a new task
  void createNewtask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            tcontoller: _taskController,
            cContoller: _contentController,
            onCancel: () {
              Get.back();
            },
            onSave: savedNewTask,
          );
        });
        db.updatedata();
  }

  //delete Task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updatedata();
  }

  // Edit task
  void editTask(int index) {
    _taskController.text = db.toDoList[index][0];
    _contentController.text = db.toDoList[index][1];
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          tcontoller: _taskController,
          cContoller: _contentController,
          onCancel: () {
            Get.back();
          },
          onSave: () {
            setState(() {
              db.toDoList[index][0] = _taskController.text;
              db.toDoList[index][1] = _contentController.text;
            });
            db.updatedata();
            Get.back();
          },
        );
      },
    );
    db.updatedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 4),
                child: Text(
                  "Hello There!!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: ConstColors.mainTextColor),
                ),
              ),
              const Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Welcome back..",
                ),
              ),
              const SizedBox(
                height: 4,
              ),

              //ListTile
              Container(
                height: MediaQuery.of(context).size.height * 0.7,

                //todo list was empty show image or shpow TodoTiles
                child: db.toDoList.isEmpty ? Center(child: Column(
                  children: [
                    SizedBox(height: 90,),
                    Image.asset('assets/images/emptydata.jpg'),
                    Text("    Your task was empty😒",style: TextStyle(fontSize: 20),)
                  ],
                ),):ListView.builder(
                  itemCount: db.toDoList.length,
                  itemBuilder: (context, index) {
                    return TodoTile(
                      taskTitle: db.toDoList[index][0],
                      taskContent: db.toDoList[index][1],
                      taskCompleted: db.toDoList[index][2],
                      onChanged: (value) => CheckboxChanged(value, index),
                      deleteFunction: (context) => deleteTask(index),
                      editFunction: (context) => editTask(index),
                    );
                  },
                ),
              )
            ],
          ),
        ),

        //BottomAppbar
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: ConstColors.secondaryColor,
        onPressed: () {
          createNewtask();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        color: ConstColors.mainColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
