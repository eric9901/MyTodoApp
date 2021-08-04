

import 'package:flutter/material.dart';

import 'package:todoapp/screens/taskPapge.dart';

import '../database_helper.dart';
import '../widget.dart';
class Homepage extends StatefulWidget {
  @override
  _HomepageStat createState() => _HomepageStat();
}
class _HomepageStat extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
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
                     child: FutureBuilder(
                       initialData: [],
                       future: _dbHelper.getTasks(),
                       builder: (context, AsyncSnapshot snapshot){
                         return ScrollConfiguration(
                          behavior: NoGlowBehaviour(), 
                          child: ListView.builder(   
                           itemCount: snapshot.data!.length ,
                           itemBuilder: (context, index){
                             return GestureDetector(
                               onTap:(){
                                Navigator.push(context,
                                MaterialPageRoute( builder:(context) =>Taskpage(
                                  task: snapshot.data![index],
                                 )),
                                ).then((value) {setState(() {
                                  
                                });});
                               },
                             child: TaskCardWidget(
                               title: snapshot.data![index].title,
                             ),);
                             },
                         ),
                         );
                       },
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
                       builder: (context)=> Taskpage(task: null)
                       ),
                     ).then((value){
                       setState(() {});
                     });
                   },
                 child: Container(  
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                   colors: [Color(0xFF60F078),Color(0xFF643FDB)],
                   begin: Alignment(0.0,-1.0),
                   end: Alignment(0.0,1.0)
                    ),
                   borderRadius: BorderRadius.circular(20.0),
                 ),
                  child: Image(
                    image: AssetImage(
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