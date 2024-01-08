import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_kiss/poem.dart';

class pathPage extends StatefulWidget {

  pathPage({super.key, required this.language});
  final String language;

  @override
  State<pathPage> createState() => _pathPageState();
}

class _pathPageState extends State<pathPage> {

  List _items = [];

  Future <void> readJson() async{
    final response = await rootBundle.loadString('assets/poetry.json');
    final data = await json.decode(response);
    setState(() {
      _items = data[widget.language];
    });
  }

  final List<Color> cardColors = [
    Color(0xFF607274),
    Color(0xFFFAEED1),
    Color(0xFFDED0B6),
    Color(0xFFB2A59B),
  ];

  
  @override
  Widget build(BuildContext context){
    readJson();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
               ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              Container(width: 50,),
              SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: Column (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                               Icon(Icons.people_alt_rounded,size: 38,),
                               Text(_items[0]['title'])
                              ],),
                        onPressed: (){
                                    var snackBar = SnackBar(content: Text(_items[0]['url']));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => poemPage(language: widget.language, poem: 0)));
                                  },),
                    ),
            ],
          ),
          Container(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 15,),
              SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: Column (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                               Icon(Icons.remove_red_eye_rounded,size: 38,),
                               Text(_items[1]['title'])
                              ],),
                        onPressed: (){
                                    var snackBar = SnackBar(content: Text(_items[1]['url']));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => poemPage(language: widget.language, poem: 1)));
                                  },),
                    ),
            ],
          ),
          Container(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 25,),
              SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: Column (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                               Icon(Icons.handshake_rounded,size: 38,),
                               Text(_items[2]['title'])
                              ],),
                        onPressed: (){
                                    var snackBar = SnackBar(content: Text(_items[2]['url']));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => poemPage(language: widget.language, poem: 2)));
                                  },),
                    ),
            ],
          ),
          Container(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 45,),
              SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: Column (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                               Icon(Icons.people_alt,size: 38,),
                               Text(_items[3]['title'])
                              ],),
                        onPressed: (){
                                    var snackBar = SnackBar(content: Text(_items[3]['url']));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => poemPage(language: widget.language, poem: 3)));
                                  },),
                    ),
            ],
          ),
          
          ],
        ),
      ),
    );
  }
}



