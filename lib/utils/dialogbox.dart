import 'package:flutter/material.dart';
import 'package:todoapp/utils/buttons.dart';

class dialogbox extends StatefulWidget {
  final Controller_1;
  final Controller_2;
  final VoidCallback save;
  final VoidCallback cancel;

  dialogbox({
    super.key,
    this.Controller_1,
    this.Controller_2,
    required this.save,
    required this.cancel,
  });

  @override
  State<dialogbox> createState() => _dialogboxState();
}

class _dialogboxState extends State<dialogbox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Task To-Do"),
      content: Container(
        height: 270,
        // Column
        child: Column(
          children: [
            //Task Title
            Container(
              height: 70,
              width: 300,
              child: TextField(
                controller: widget.Controller_1,
                decoration: InputDecoration(
                    hoverColor: Color.fromRGBO(131, 83, 105, 1),
                    hintText: "Enter Task Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(131, 83, 105, 1)))),
              ),
            ),
            // Size or space
            SizedBox(
              height: 10,
            ),
            //Task Detail
            Container(
              height: 70,
              width: 300,
              child: TextField(
                controller: widget.Controller_2,
                decoration: InputDecoration(
                    hoverColor: Color.fromRGBO(131, 83, 105, 1),
                    hintText: "Enter Detail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(131, 83, 105, 1)))),
              ),
            ),

            // Gap or Space
            SizedBox(
              height: 10,
            ),
            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Apply
                dialogButton(
                  outlinecolors: Colors.transparent,
                  bgcolors: Color.fromRGBO(131, 83, 105, 1),
                  onpressed: widget.save,
                  text1: "Save",
                  textstyle: TextStyle(color: Colors.white),
                ),
                // Cancel
                dialogButton(
                  outlinecolors: Color.fromRGBO(131, 83, 105, 1),
                  onpressed: widget.cancel,
                  text1: "Cancel",
                  textstyle: TextStyle(
                    color: Color.fromRGBO(131, 83, 105, 1),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
