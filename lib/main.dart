import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The patth to a Kiss',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  int currentIndex = 0;
  Map cardText = {
      'title': ['Elije un poema'],
      'name': ['Deseo','Ojos','Manos','Beso'],
      'first': ['Deseo1','Ojos1','Manos1','Beso1'],
      'url': ['url_deseo_sp','url_ojos_sp','url_manos_sp','url_beso_pt'],
      'buttons': ['Leer & escuchar', 'Sólo escuchar']
  };
  final List<Color> cardColors = [
    Colors.amber,
    Colors.blueGrey,
    Colors.orange,
    Colors.lightBlue,
  ];

  final List<String> languages = [
    "Español","English","Portugues", "Français"
  ];

    void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % 4;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              cardText['title'][0],
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            alignment: Alignment.center,
            height: 300,
            child: GestureDetector(
              onTap: nextCard,
              child: Stack(
                children: <Widget>[
                  for (int i = 0; i < 4; i++)
                    if (currentIndex == i)
                      Positioned(
                        top: 20.0 * i,
                        left: 20.0 * i,
                        child: Container(
                          width: 300,
                          child: Card(
                            elevation: 4.0,
                            color: cardColors[i],
                            child: Column (
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                 ListTile(
                                  leading: Icon(Icons.soap),
                                  title: Text(cardText['name'][i]),
                                  subtitle: Text(cardText['first'][i]),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: (){
                                        showDialog(
                                          context: context, 
                                          builder: (BuildContext context){
                                            return AlertDialog(
                                              title: Text(cardText['name'][i]),
                                              content: Text('Lorem Ipso'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: (){Navigator.of(context).pop();}, 
                                                  child: Text('Close'))
                                              ],
                                            );
                                          }
                                          );
                                    }, 
                                    child: Text(cardText['buttons'][0])),
                                    TextButton(
                                      onPressed: (){
                                        var snackBar = SnackBar(content: Text(cardText['url'][i]));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }, child: Text(cardText['buttons'][1])),
                                  ],
                                )
                              ],
                            )
                            ),
                        )
                      ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: DropdownButton<String>(
            hint: Text("Language"),
            value: null,
            items: languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            onChanged: (String? value) {
                switch (value){
                  case null:
                  setState(() {
                      cardText['title']= ['Elije un poema'];
                      cardText['name'] = ['Deseo','Ojos','Manos','Beso'];
                      cardText ['first']= ['Deseo1','Ojos1','Manos1','Beso1'];
                      cardText['url']= ['url_deseo_sp','url_ojos_sp','url_manos_sp','url_beso_pt'];
                      cardText['buttons']= ['Leer & escuchar', 'Sólo Escuchar'];
                    });
                  break;
                  case "Español":
                  setState(() {
                      cardText['title']= ['Elije un poema'];
                      cardText['name'] = ['Deseo','Ojos','Manos','Beso'];
                      cardText ['first']= ['Deseo1','Ojos1','Manos1','Beso1'];
                      cardText['url']= ['url_deseo_sp','url_ojos_sp','url_manos_sp','url_beso_pt'];
                      cardText['buttons']= ['Leer & escuchar', 'Sólo Escuchar'];
                    });
                  break;
                  case "English":
                  setState(() {
                      cardText['title'] = ['Choose a poem'];
                      cardText['name']= ['Desire', 'Eyes', 'Hands', 'Kiss'];
                      cardText['first']= ['Desire1', 'Eyes1', 'Hands1', 'Kiss1'];
                      cardText['url']= ['url_deseo_en','url_ojos_en','url_manos_en','url_beso_en'];
                      cardText['buttons'] = ['Read & Listen', 'Listen Only'];

                   });
                  break;
                  case "Portugues":
                  setState(() {
                      cardText['title'] = ['Escolha um poema'];
                      cardText['name']= ['Desejo', 'Olhos', 'Mãos', 'Beijo'];
                      cardText['first']= ['Desejo1', 'Olhos1', 'Mãos1', 'Beijo1'];
                      cardText['url']= ['url_deseo_pt','url_ojos_pt','url_manos_pt','url_beso_pt'];
                      cardText['buttons'] = ['Ler & Ouvir', 'Apenas Ouvir'];
                          });
                  break;
                  case "Français":
                  setState(() {
                      cardText['title'] = ['Choisissez un poème'];
                      cardText['name']= ['Désir', 'Yeux', 'Mains', 'Baiser'];
                      cardText['first']= ['Désir1', 'Yeux1', 'Mains1', 'Baiser1'];
                      cardText['url']= ['url_deseo_sp','url_ojos_sp','url_manos_','url_beso_fr'];
                      cardText['buttons'] = ['Lire & Écouter', 'Écouter Seulement'];
                  });
                  break;
                }                
              }),
          )
          ],
        ),
      ),
     /* floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),  This trailing comma makes auto-formatting nicer for build methods.*/
    );
  }
}
