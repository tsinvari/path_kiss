import 'package:flutter/material.dart';
import 'package:path_kiss/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The patth to a Kiss',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'The path to a Kiss'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  String selecLanguage = "Español";

  final List<Color> cardColors = [
    Color(0xFF607274),
    Color(0xFFFAEED1),
    Color(0xFFDED0B6),
    Color(0xFFB2A59B),
  ];

  final List<String> languages = [
    "Español","English","Portugues", "Français"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 100,
               ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: DropdownButton<String>(
                hint: Text("Language"),
                value: selecLanguage,
                items: languages.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                onChanged: (String? value) {
                  if (value != null){
                    setState(() {
                      selecLanguage = value;
                    });
                  }              
                  }),
              )
              ],
            ),
          Container(
            alignment: Alignment.center,
            height: 600,
              child: Column(
                children: <Widget>[
                  Container(
                          height: 140,
                          width: 300,
                          child: Text("En el amor eres la luz mas certera"),
                        ),
                  ElevatedButton(
                    onPressed: (){Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => pathPage(language: selecLanguage,)));}, 
                    child: Icon(Icons.next_plan_rounded)),                  
                ],
              )
          ),         
          ],
        ),
      ),
    );
  }
}
