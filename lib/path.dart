import 'dart:convert';
import 'dart:math';
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

    Widget customButton(int index, double angleRotationPic) {
    return Transform.rotate(
      angle: angleRotationPic * (pi / 180),
      child: Container(
        decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Adjust the shadow color and opacity
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Adjust the shadow offset
          ),
        ],
      ),
        child: GestureDetector(
          onTap: () {
            if (index < _items.length) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => poemPage(language: widget.language, poem: index),
              ));
            }
          },
          child: 
          Stack(
          alignment: Alignment.center,
            children: <Widget>[
              if (index < _items.length)
                 Image.asset(
                    _items[index]['image_url'],
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
              if (index < _items.length)  
                Column(
                  children: [
                    Container(
                      height: 250,
                    ),              
                    Text(
                      _items[index]['title'],
                      style: const TextStyle(
                        fontSize: 24, // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MarketPro')),
                        
                  ],
                ),
            ],
          ),
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
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'), 
            fit: BoxFit.cover, 
          ),
        ),
        child: SingleChildScrollView(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  customButton(0,345)
              ],
            ),
            Container(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customButton(1,15)
              ],
            ),
            Container(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customButton(2,325)
              ],
            ),
            Container(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customButton(3,0)
              ],
            ),
            Container(height: 75,),  
            ],
          ),
        ),
      ),
    );
  }
}



