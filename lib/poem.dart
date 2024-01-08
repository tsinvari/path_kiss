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

 late List _items = [];

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
      body: Stack(
        children: [
          if (_items.isNotEmpty && widget.poem < _items.length)
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_items[widget.poem]['image_url']),
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
                )
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50,),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  ),
                if (_items.isNotEmpty && widget.poem < _items.length)
                Column(
                  children: [
                    Text(
                      _items[widget.poem]['title'] ?? 'No title available',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 20,),
                    if (_items.isNotEmpty && widget.poem < _items.length)
                    Text(
                      _items[widget.poem]['poem'] ?? 'No poem available',
                      style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
                    const SizedBox(height: 100,),
                        ]            
                      ),
                ],
              ),
              ),
        ],
      ),
      );
     }
}



