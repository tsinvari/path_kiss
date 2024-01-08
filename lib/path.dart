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
      width: 150,
      height: 150,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.people_alt_rounded, size: 38),
            if (index < _items.length) Text(_items[index]['title']),
          ],
        ),
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
                height: 100,
               ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              Container(width: 50,),
              customButton(0)
            ],
          ),
          Container(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 78,),
              customButton(1)
            ],
          ),
          Container(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 135,),
              customButton(2)
            ],
          ),
          Container(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 190,),
              customButton(3)
            ],
          ),
          
          ],
        ),
      ),
    );
  }
}



