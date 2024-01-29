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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Text("Path to a kiss", 
                          style: TextStyle(
                            fontFamily: "MarketPro",
                            color: Colors.amber,
                            fontSize: 40,
                          ),),
                  )
                ],
              ),
            Container(height: 15,),
            Container(
              alignment: Alignment.center,
              height: 800,
                child: Column(
                  children: <Widget>[
                     Container(
            /*          decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2), 
                      borderRadius: BorderRadius.circular(10), 
                    ),*/
                    padding: const EdgeInsets.all(16),
                            width: 300,
                            child: const Text("I like to think that everything in life has 4 phases, from the moment the desire comes to us to moment it comes true. \n\n    We desire,\n        we see, \n            we try, \n                we materialize.",
                            style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'WorstveldSling',
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                        ),),
                          ),
                    Container(height: 50),
                    ElevatedButton(
                      onPressed: (){Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => PathPage()));}, 
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
