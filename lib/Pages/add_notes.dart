import 'package:flutter/material.dart';

class Add_Note extends StatefulWidget {
  // Constructors
  final Controller_1;
  final Controller_2;
  final VoidCallback? save;
  final VoidCallback? back;
  Add_Note(
      {super.key, this.Controller_1, this.Controller_2, this.save, this.back});

  @override
  State<Add_Note> createState() => _Add_NoteState();
}

class _Add_NoteState extends State<Add_Note> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar
      appBar: AppBar(
          title: Text("Notes"),
          centerTitle: true,
          leading: IconButton(
              onPressed: widget.back,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color.fromRGBO(131, 83, 105, 1),
              ))),
      // Body
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(15),
                //List
                child: ListView(
                  children: [
                    // TextField 1
                    SizedBox(
                      width: 350,
                      child: TextField(
                        controller: widget.Controller_1,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ).copyWith(overflow: TextOverflow.fade),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Title Here",
                            hintStyle: TextStyle(
                                fontSize: 22,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    // textfield 2
                    SizedBox(
                      width: 350,
                      child: TextField(
                        controller: widget.Controller_2,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 3000,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Detail Here",
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: widget.save,
          child: Icon(
            Icons.save_rounded,
            color: Colors.white,
          ),
          backgroundColor: Color.fromRGBO(131, 83, 105, 1),
          shape: CircleBorder()),
    );
  }
}
