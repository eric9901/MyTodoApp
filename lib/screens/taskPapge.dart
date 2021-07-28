import 'package:flutter/material.dart';

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
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Padding(
            padding: EdgeInsets.symmetric(
              vertical:24.0,
            ),
         child: Row(
            children: [
              InkWell(
                onTap:(){
                  Navigator.pop(context);
                },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image(
                 image: AssetImage(
                  "assets/images/back_arrow_icon.png"
                 ),
                ),
              ),
              ),
              Expanded(
                child: TextField(
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
            padding: const EdgeInsets.all(8.0),
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
          TodoWidget(),
        ], 
      ),
        ),
      ),
    );
  }
}