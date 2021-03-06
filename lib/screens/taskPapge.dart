import 'package:flutter/material.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widget.dart';

import '../database_helper.dart';

class Taskpage extends StatefulWidget {
  final Task? task;
  Taskpage({required this.task});
  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  int? _taskId = 0;
  String? _taskTitle = "";
  String? _taskDescription = "";
  String? _toDOText = "";

  FocusNode? _titleFocus;
  FocusNode? _descriptionForcus;
  FocusNode? _todoFocus;

  bool _contentVisile = false;

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisile = true;
      _taskTitle = widget.task!.title;
      _taskDescription = widget.task!.description;
      _taskId = widget.task!.id;
    }
    _titleFocus = FocusNode();
    _descriptionForcus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus!.dispose();
    _descriptionForcus!.dispose();
    _todoFocus!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24.0,
                      bottom: 6.0,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage(
                                  "assets/images/back_arrow_icon.png"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (widget.task == null) {
                                  Task _newTask = Task(title: value);
                                  _taskId =
                                      await _dbHelper.insertTask(_newTask);
                                  setState(() {
                                    _contentVisile = true;
                                    _taskTitle = value;
                                  });
                                } else {
                                  await _dbHelper.updateTaskTitle(
                                      _taskId!, value);
                                  print("Task updated");
                                }

                                _descriptionForcus!.requestFocus();
                              }
                            },
                            controller: TextEditingController()
                              ..text = _taskTitle!,
                            decoration: InputDecoration(
                              hintText: "Enter Task Title",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF211551),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _contentVisile,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12.0,
                      ),
                      child: TextField(
                        focusNode: _descriptionForcus,
                        onSubmitted: (value) {
                          if (value != "") {
                            if (_taskId != 0) {
                              _dbHelper.updateTaskDescription(_taskId!, value);
                              _taskDescription = value;
                              print("success update. content:" + value);
                            }
                          }
                          _todoFocus!.requestFocus();
                        },
                        controller: TextEditingController()
                          ..text = _taskDescription ?? "",
                        decoration: InputDecoration(
                            hintText: "Enter Description for the task...",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                            )),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _contentVisile,
                    child: FutureBuilder(
                        initialData: [],
                        future: _dbHelper.getTodos(_taskId!),
                        builder: (context, AsyncSnapshot snapshot) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    if (snapshot.data[index].isDone == 0) {
                                      await _dbHelper.updateTodoDone(
                                          snapshot.data[index].id, 1);
                                    } else {
                                      await _dbHelper.updateTodoDone(
                                          snapshot.data[index].id, 0);
                                    }
                                    setState(() {});
                                  },
                                  child: TodoWidget(
                                    text: snapshot.data[index].title,
                                    isDone: snapshot.data[index].isDone == 0
                                        ? false
                                        : true,
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                  ),
                  Visibility(
                    visible: _contentVisile,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            height: 20.0,
                            margin: EdgeInsets.only(
                              right: 12.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: Color(0xFF9DA5B2), width: 1.5)),
                            child: Image(
                              image: AssetImage('assets/images/check_icon.png'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                                focusNode: _todoFocus,
                                controller: TextEditingController()..text = "",
                                onSubmitted: (value) async {
                                  if (value != "") {
                                    if (_taskId != 0) {
                                      DatabaseHelper _dbHelper =
                                          DatabaseHelper();
                                      Todo _newTodo = Todo(
                                        title: value,
                                        isDone: 0,
                                        taskId: _taskId,
                                      );
                                      await _dbHelper.insertTodo(_newTodo);
                                      setState(() {});
                                      _todoFocus!.requestFocus();
                                    } else {
                                      print("Task dosen't exist");
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter Todo item..",
                                  border: InputBorder.none,
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: _contentVisile,
                child: Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () async {
                      if (_taskId != 0) {
                        await _dbHelper.deleteTask(_taskId!);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF8449D2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image(
                        image: AssetImage("assets/images/delete_icon.png"),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
