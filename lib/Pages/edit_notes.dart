import 'package:flutter/material.dart';

class Edit_Note extends StatefulWidget {
  final TextEditingController Controller_1;
  final TextEditingController Controller_2;
  final VoidCallback? save;
  final VoidCallback? back;
  Edit_Note({
    super.key,
    required this.Controller_1,
    required this.Controller_2,
    this.save,
    this.back,
  });

  @override
  State<Edit_Note> createState() => _Edit_NoteState();
}

class _Edit_NoteState extends State<Edit_Note> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Notes"),
          centerTitle: true,
          leading: IconButton(
              onPressed: widget.back,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color.fromRGBO(131, 83, 105, 1),
              ))),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView(
                  children: [
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
