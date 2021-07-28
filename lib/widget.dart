
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String? title;
  final String? desc;
  TaskCardWidget({this.title,this.desc});
  @override
  Widget build(BuildContext context){
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0
    ),
    margin: EdgeInsets.only(
      bottom: 40.0,

    ),
    decoration: BoxDecoration(
      color: Colors.pink,
      borderRadius: BorderRadius.circular(20.0)
    ),
    child: Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children:[
       Text(
      title ?? "(Unnamed Task)",
      style: TextStyle(
        color:Color(0xff211551),
        fontSize:22.0,
        fontWeight: FontWeight.bold,
        ),
       ),
       Padding(
         padding: EdgeInsets.only(
           top:10.0, 
           ),
       child:Text(
         desc ?? "No Description Added.",
         style:TextStyle(
           fontSize: 16.0,
           color:Color(0xFFFFFFFF)
          ),
        ),
       ),
      ],
    ),
  );
 }
}

class TodoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width:20.0,
            height:20.0,
           /* decoration: BoxDecoration(
              color: Color(0xFF7349FE)
            ),*/
          color:Color(0xFF7349FE),
          child: Image(
            image: AssetImage(
              'assets/images/check_icon.png'
            ),
           ),
          ),
          Text("todo"),
          
        ],
      ),
    );
  }
}