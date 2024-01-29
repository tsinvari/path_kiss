import 'dart:convert';
import 'dart:math';
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
 int poemIndex = 0;
 final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _items = [];
    _audioPlayer = AudioPlayer();
    poemIndex = widget.poem;

    readJson();
    Future.delayed(const Duration(milliseconds: 300), () {
      playBackgroundMusic(poemIndex);
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
    Future<void> playBackgroundMusic(int index) async {
    try {
      if (_items.isNotEmpty && index < _items.length) {
      await _audioPlayer.play(AssetSource(_items[index]['mp3_url']));
      }
    } catch (e) {  }
  }
  
  
  @override
  Widget build(BuildContext context){
    readJson();
    return Scaffold(
      body: Stack(
        children: [
          if (_items.isNotEmpty && poemIndex < _items.length)
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.9),  BlendMode.dstOver)
                )
            ),
          ),
          SingleChildScrollView(
            controller: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  ),
                if (_items.isNotEmpty && poemIndex < _items.length)
                Column(
                  children: [
                    Text(
                      _items[poemIndex]['title'] ?? 'No title available',
                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 42,fontFamily: 'MarketPro',),),
                    const SizedBox(height: 8,),
                    if (_items.isNotEmpty && poemIndex < _items.length)
                    Container(
                    padding: const EdgeInsets.fromLTRB(2, 16, 2, 16),
                      child: Text(
                        _items[poemIndex]['poem'] ?? 'No poem available',
                        style: const TextStyle(fontSize: 30, fontFamily: 'WorstveldSling' ,color: Colors.white),textAlign: TextAlign.center,),
                    ),
                    const SizedBox(height: 5,),
                        ]            
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom:30), 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (poemIndex >0 && poemIndex < 4)?
                            SizedBox(
                              height: 35,
                              width: 100,
                              child: ElevatedButton( //previous
                                onPressed: () async {
                                   {
                                  _audioPlayer.stop();
                                  _controller.animateTo(0,
                                              duration: Duration(milliseconds: 300),
                                              curve: Curves.easeIn);
                                  setState(() {
                                    poemIndex -= 1;
                                  });
                                  Future.delayed(const Duration(milliseconds: 300), () {
                                    playBackgroundMusic(poemIndex);
                                  });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                  ),
                                child: Transform.scale(
                                  scaleX: 2,
                                  child: Transform.rotate(
                                    angle: 180 * (pi / 180) ,
                                    child: Image.asset(
                                            'assets/icons/arrow.png', 
                                            fit: BoxFit.contain, 
                                            color: Colors.white, 
                                          ),
                                  ),
                                ),
                              ),
                            )
                            :(poemIndex == 4)?
                            const SizedBox(
                              height: 35,
                              width: 100,
                            )
                            :
                            const SizedBox(
                              height: 35,
                              width: 100,
                            ), 
                        
                            SizedBox(
                              height: 35,
                              width: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  _audioPlayer.stop();
                                 Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                  ),
                                child: Transform.scale(
                                  scale: 30,
                                  child: Image.asset(
                                              'assets/icons/photo.png', 
                                              fit: BoxFit.contain, 
                                           //   color: Colors.white, 
                                            ),
                                ),
                              ),
                            ),
                        
                            ( poemIndex < 3 )?
                            SizedBox(
                              height: 35,
                              width: 100,
                              child: ElevatedButton( //Next
                                 onPressed: () async {
                                  _audioPlayer.stop();
                                  setState(() {
                                    poemIndex += 1;
                                  });
                                  _controller.animateTo(0,
                                              duration: const Duration(milliseconds: 300),
                                              curve: Curves.easeIn);
                                  Future.delayed(const Duration(milliseconds: 300), () {
                                    playBackgroundMusic(poemIndex);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.transparent,
                                ),
                                child: Transform.scale(
                                  scaleX: 2,
                                  child: Image.asset(
                                        'assets/icons/arrow.png', 
                                        fit: BoxFit.contain, 
                                        color: Colors.white, 
                                      ),
                                ),
                              ),
                            )
                            : (poemIndex == 3) ?
                            SizedBox(
                              height: 35,
                              width: 100,
                              child: ElevatedButton(
                                 onPressed: () async {
                                  setState(() {
                                    poemIndex +=1;
                                    _controller.animateTo(0,
                                              duration: Duration(milliseconds: 300),
                                              curve: Curves.easeIn);
                                    Future.delayed(const Duration(milliseconds: 300), () {
                                    playBackgroundMusic(poemIndex);
                                  });
                                  });
                                },
                                 style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                  ),
                                child: Transform.scale(
                                  scale: 2,
                                  child: Image.asset(
                                                'assets/icons/treasure.png', 
                                                fit: BoxFit.contain, 
                                                color: Colors.white, 
                                              ),
                                ),
                              ),
                            )
                            :
                            const SizedBox(
                              height: 35,
                              width: 100,
                            )
                          ],
                        ),
                      ),
                ],
              ),
              ),
        ],
      ),
      );
     }
}



