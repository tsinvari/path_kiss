import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_kiss/poem.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

class pathPage extends StatefulWidget {

  pathPage({super.key, required this.language});
  final String language;

  @override
  State<pathPage> createState() => _pathPageState();
}

class _pathPageState extends State<pathPage> {

  late List _items;

  @override
  void initState() {
    super.initState();
    _items = []; 
    readJson();
  }

    Future<void> readJson() async {
    try {
      final response = await rootBundle.loadString('assets/poetry.json');
      final data = await json.decode(response);
      setState(() {
        _items = data[widget.language] ?? []; // Handle empty case
      });
    } catch (e) {
      print('Error loading JSON: $e');
    }
  }

    Widget customButton(int index) {
    return Container(
      width: 120,
      height: 120,
      child: ElevatedButton(
        onPressed: () {
          if (index < _items.length) {
            var snackBar = SnackBar(content: Text(_items[index]['url']));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => poemPage(language: widget.language, poem: index),
            ));
          }
        },
        style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60), // Circular shape
              ),
              elevation: 8, // Elevation at the bottom
            ),
        child: 
        Stack(
        //  mainAxisAlignment: MainAxisAlignment.center,
        alignment: Alignment.center,
          children: <Widget>[
            if (index < _items.length)
               Image.asset(
                  _items[index]['icon_path'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
            if (index < _items.length)  
              ArcText(
                  radius: 55, 
                  text: _items[index]['title'],
                  placement: Placement.inside,
                  startAngle: -pi ,
                  direction: Direction.counterClockwise,
              ),
          ],
        ),
      ),
    );
  }

      Widget customDot(double angleFeet) {
    return Container(
      width: 50,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25), // Circular shape
              ),
              elevation: 8, // Elevation at the bottom
            ),
        child: Transform.scale(
          scale: 10,
          child: Transform.rotate(
            angle: angleFeet * (pi / 180),
            child: Image.asset(
                      "assets/icons/footprints.png",
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,),
          ),
        )
      ),
    );
  }

  
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
                height: 75,
               ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 35,),
              customButton(0)
            ],
          ),
          Container(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 90,),
              customDot(135)
            ],
          ),
                    Container(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 120,),
              customDot(135)
            ],
          ),
          Container(height: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 138,),
              customButton(1)
            ],
          ),
          Container(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 175,),
              customDot(185)
            ],
          ),
                    Container(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 160,),
              customDot(185)
            ],
          ),
          Container(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 140,),
              customButton(2)
            ],
          ),
          Container(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 178,),
              customDot(135)
            ],
          ),
                    Container(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 200,),
              customDot(135)
            ],
          ),
          Container(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 210,),
              customButton(3)
            ],
          ),
             Container(height: 75,),  
          ],
        ),
      ),
    );
  }
}



