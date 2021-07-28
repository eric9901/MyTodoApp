import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todoapp/screens/taskPapge.dart';

import '../widget.dart';
class Homepage extends StatefulWidget {
  

  @override
  _HomepageStat createState() => _HomepageStat();
}

class _HomepageStat extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 24.0, 
          
           ),
           color: Color(0x66CCFF),
           child: Stack(
             children: [
               Column(       
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children:[
                   Container(
                     margin: EdgeInsets.only(
                       top: 32.0,
                       bottom:32.0,
                     ),
                   ),
                   Image(
                     image: AssetImage(
                       "assets/images/logo.png",
                    ),
                  ),
                  Expanded(
                    child: ListView(
                    children: [
                      TaskCardWidget(
                    title: "Get Started! Let try my to do app",
                    desc: "Welcom User. Here is my Todo app. This is the default remind that you can edit or delete to start using the app."
                  ),
                  TaskCardWidget(),
                  TaskCardWidget(),
                  TaskCardWidget(),
                  TaskCardWidget(),
                  ],
                    ),
                  ),
                 ],
                ),
               Positioned(
                 bottom:24.0,
                 right:0.0,
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
                   color: Color(0xFF46FF90),
                   borderRadius: BorderRadius.circular(20.0),
                 ),
                  child: Image(
                    image: AssetImage(
                      //"assets\images\add_icon.png"
                      "assets/images/add_icon.png"
                    
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