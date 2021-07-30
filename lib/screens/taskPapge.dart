import 'package:flutter/material.dart';
import 'package:todoapp/model/task.dart';

import '../database_helper.dart';
import '../widget.dart';

class Taskpage extends StatefulWidget {
  
  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child:Container(
          child: Stack(
         children:[ 
           Column(
           crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Padding(
            padding: EdgeInsets.only(
              top:24.0,
              bottom: 6.0,
            ),
         child: Row(
            children: [
              InkWell(
                onTap:(){
                  Navigator.pop(context);
                },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                 image: AssetImage(
                  "assets/images/back_arrow_icon.png"
                 ),
                ),
              ),
              ),
              Expanded(
                child: TextField(
                  onSubmitted: (value) async {
                    print("Field Value: $value");

                    if(value != ""){
                       DatabaseHelper _dbHelper = DatabaseHelper();

                       Task _newTask = Task(
                         title: value
                       );
                       await _dbHelper.insertTask(_newTask);

                       print("New Task has been created");
                    }
                  },
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
          Padding(
            padding: const EdgeInsets.only(
              bottom:12.0,
            ),
            child: TextField(
              decoration:InputDecoration(
                hintText: "Enter Description for the task",
                 border: InputBorder.none,
                 contentPadding: EdgeInsets.symmetric(
                   horizontal: 64.0,
                 )
                 ),
                ),
          ),
          TodoWidget(
            text: "Crate your first Task",
            isDone: false,
          ),
          TodoWidget(
            text: "Create your first todo as well",
            isDone: false,
          ),
          TodoWidget(
            text:"another todo",
            isDone: true,
          ),
          TodoWidget(
            isDone: true,
          ),
        ], 
      ),
          Positioned(
                 bottom:24.0,
                 right:24.0,
                 child: GestureDetector(
                   onTap: (){
                     Navigator.push(context, 
                     MaterialPageRoute(
                       builder: (context)=> Taskpage()
                       ),
                     );
                   },
                 child: Container(  
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    
                   color: Color(0xFF8449D2),
                   borderRadius: BorderRadius.circular(20.0),
                 ),
                  child: Image(
                    image: AssetImage(
                      "assets/images/delete_icon.png"                    
                     ),                  
                    ),
                 ),
                ),
               ),
           
         ],
          ),
        ),
      ),
    );
  }
}