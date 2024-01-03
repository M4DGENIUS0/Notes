import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/Pages/add_notes.dart';

// ignore: must_be_immutable
class TodoList extends StatefulWidget {
  final String TextName;
  final String TextDetail;
  Function(BuildContext) DeleteTask;
  Function(BuildContext) EditTask;

  TodoList({
    super.key,
    required this.TextName,
    required this.TextDetail,
    required this.DeleteTask,
    required this.EditTask,
  });

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: SizedBox(
        width: 400,
        child: Slidable(
          endActionPane: ActionPane(motion: DrawerMotion(), children: [
            SlidableAction(
              autoClose: true,
              padding: EdgeInsets.all(10),
              spacing: 3,
              onPressed: widget.EditTask,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Color.fromRGBO(131, 83, 105, 1),
              foregroundColor: Colors.white,
            ),
            SlidableAction(
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
              foregroundColor: Colors.white,
              onPressed: widget.DeleteTask,
              icon: Icons.delete,
            ),
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Add_Note()));
              },
              child: Container(
                height: 130,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.TextName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.TextDetail,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(color: Colors.black)
                                  .copyWith(overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
