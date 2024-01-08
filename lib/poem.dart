import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class poemPage extends StatefulWidget {

  poemPage({super.key, required this.language, required this.poem});
  final String language;
  final int poem;

  @override
  State<poemPage> createState() => _poemPageState();
}

class _poemPageState extends State<poemPage> {
int currentIndex = 0;

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
          Container(
            alignment: Alignment.center,
              child: Text(widget.poem.toString())
          ),
          Container(
            alignment: Alignment.center,
            child: Text(_items[widget.poem]['poem']),
          )
         
          ],
        ),
      ),
    );
  }
}



