import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class PoemPage extends StatefulWidget {

  PoemPage({super.key, required this.language, required this.poem});
  final String language;
  final int poem;

  @override
  State<PoemPage> createState() => PoemPageState();
}

class PoemPageState extends State<PoemPage> {
int currentIndex = 0;

 late List _items = [];
 late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _items = [];
    _audioPlayer = AudioPlayer();
    readJson();
    Future.delayed(const Duration(milliseconds: 300), () {
      playBackgroundMusic();
    });
  }
    @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


    Future<void> readJson() async {
    try {
      final response = await rootBundle.loadString('assets/poetry.json');
      final data = await json.decode(response);
      setState(() {
        _items = data[widget.language] ?? []; // Handle empty case
      });
    } catch (e) { }
  }
    Future<void> playBackgroundMusic() async {
    try {
      if (_items.isNotEmpty && widget.poem < _items.length) {
      await _audioPlayer.play(AssetSource(_items[widget.poem]['mp3_url']));
      }
    } catch (e) {  }
  }
  
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
                  image: const AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop)
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
                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white54, fontSize: 26,fontFamily: 'MarketPro',),),
                    const SizedBox(height: 20,),
                    if (_items.isNotEmpty && widget.poem < _items.length)
                    Container(
                      decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2), // Soft colored box
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    padding: const EdgeInsets.fromLTRB(2, 16, 2, 16),
                      child: Text(
                        _items[widget.poem]['poem'] ?? 'No poem available',
                        style: const TextStyle(fontSize: 18, fontFamily: 'Verdana' ,color: Colors.white54),textAlign: TextAlign.center,),
                    ),
                    const SizedBox(height: 75,),
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



