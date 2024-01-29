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

  final List<String> languages = [
    "Español","English"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration:   BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstOver)
 
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container(
                  height: 75,
                 ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
            Container(height: 30,),
            Container(
              alignment: Alignment.center,
              height: 800,
                child: Column(
                  children: <Widget>[
                     Container(
            /*          decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2), // Soft colored box
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),*/
                    padding: const EdgeInsets.all(16),
                            width: 300,
                            child: const Text("I like to think that in life everything has 4 phases, from the moment the desire comes to us to moment it comes true. \n\n    We desire,\n        we see, \n            we try, \n                we materialize.",
                            style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Verdana',
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                        ),),
                          ),
                    Container(height: 50),
                    ElevatedButton(
                      onPressed: (){Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => PathPage(language: selecLanguage,)));}, 
                      child: const Text('Walk with me',
                      style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Verdana',
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                        ),),
                      ),                  
                  ],
                )
            ),         
            ],
          ),
        ),
      ),
    );
  }
}
