import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/Pages/add_notes.dart';
import 'package:todoapp/Pages/edit_notes.dart';
import 'package:todoapp/Pages/main_Login_Sign_up.dart';
import 'package:todoapp/database/db.dart';
import 'package:todoapp/utils/todoList.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Hive to for db
  final _mynotes = Hive.box('Notes');
  notes db = notes();

  @override
  void initState() {
    // If this is first time of opening app
    if (_mynotes.get("TODOLIST") == null) {
      db.createinitialdata();
    } else {
      // if there is already existed data then
      db.loaddata();
    }

    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;
  void about() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Sign in as: " + user.toString()),
      ),
    );
  }

  bool loading = false;
  //  firebase data base
  final databaseref = FirebaseDatabase.instance.ref('notepad');

  // Text Editing Controller for Input Text
  TextEditingController _Controller_1 = TextEditingController();
  TextEditingController _Controller_2 = TextEditingController();

  // Save function used in creating notes
  void OnSave() {
    setState(() {
      db.Todolist.add([
        _Controller_1.text,
        _Controller_2.text,
      ]);
      Navigator.of(context).pop();

      db.updatedata();
      _Controller_1.clear();
      _Controller_2.clear();
    });
  }

  // Edit function when notes need to connect
  void OnEditsave(int index) {
    setState(() {
      db.Todolist[index][0] = _Controller_1.text;
      db.Todolist[index][1] = _Controller_2.text;
      db.updatedata();
    });
    _Controller_1.text = db.Todolist[index][0];
    _Controller_2.text = db.Todolist[index][1];
    Navigator.of(context).pop();
  }

  List<TodoList> filteredNotes = [];
  // Edit a task
  void editTask(int index) {
    print("clicked");

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Edit_Note(
            back: () {
              OnEditsave(index);
              Navigator.of(context).pop;
            },
            save: () => OnEditsave(index),
            Controller_1: _Controller_1,
            Controller_2: _Controller_2,
          ),
        ));
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.Todolist.removeAt(index);
      db.updatedata();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: ListView.builder(
          itemCount: db.Todolist.length,
          itemBuilder: (BuildContext context, int index) {
            return TodoList(
              TextName: db.Todolist[index][0],
              TextDetail: db.Todolist[index][1],
              EditTask: (context) => editTask(index),
              DeleteTask: (context) => deleteTask(index),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Add_Note(
                            Controller_1: _Controller_1,
                            Controller_2: _Controller_2,
                            save: OnSave,
                            back: () {
                              OnSave();
                              Navigator.of(context).pop;
                            },
                          )));
            },
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Color.fromRGBO(131, 83, 105, 1),
            shape: CircleBorder(side: BorderSide())),
        drawer: Drawer(
            child: Container(
                color: Color.fromRGBO(131, 83, 105, 1),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                        child: Icon(
                      Icons.manage_accounts_outlined,
                      size: 60,
                      color: Colors.white,
                    )),
                    GestureDetector(
                      onTap: about,
                      child: Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.info_outline_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                          title: Text("A B O U T"),
                          titleTextStyle: GoogleFonts.nunitoSans(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()));
                        });
                      },
                      child: Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          title: Text("L O G  O U T"),
                          titleTextStyle: GoogleFonts.nunitoSans(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ))),
        appBar: AppBar(
          title: Text("Todo App"),
          centerTitle: true,
        ),
      ),
    );
  }
}
