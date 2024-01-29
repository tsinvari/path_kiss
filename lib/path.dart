import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_kiss/poem.dart';

class PathPage extends StatefulWidget {

  PathPage({super.key});
  

  @override
  State<PathPage> createState() => PathPageState();
}

class PathPageState extends State<PathPage> {
   String selecLanguage = "Español";

  final List<String> languages = [
    "Español","English"
  ];

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
        _items = data[selecLanguage] ?? []; 
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
            color: Colors.black.withOpacity(0.3), 
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
        child: GestureDetector(
          onTap: () {
            if (index < _items.length) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PoemPage(language: selecLanguage, poem: index),
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
                      height: 230,
                    ),              
                    Text(
                      _items[index]['title'],
                      style: const TextStyle(
                        fontSize: 24, 
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
    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25), 
              ),
              elevation: 8, 
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
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/background.png'), 
            fit: BoxFit.cover,  
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.9),  BlendMode.dstOver)

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
                  Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                    canvasColor: Colors.black54),
                    child: Container(
                      decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10), // Set border radius here
                    ),
                      child: DropdownButton<String>(
                      dropdownColor: Colors.black.withOpacity(0),
                      underline: SizedBox(),
                      hint: const Text("Language", style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'MarketPro',),),
                      value: selecLanguage,
                      items: languages.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'MarketPro',
                                                      ),),
                          );
                        }).toList(),
                      onChanged: (String? value) {
                        if (value != null){
                          setState(() {
                            selecLanguage = value;
                          });
                        }              
                        }),
                    ),
                  ),
                )
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



