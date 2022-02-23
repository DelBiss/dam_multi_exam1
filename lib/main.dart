import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: "Développement d'application multiplatforme"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isChecked = false;
  String textBox = "";
  void _changeButtonLabel() {
    setState(() {
    });
  }

  void onTextChange (String txt){
    setState(() {
      // ignore: avoid_print
      print(txt);
      textBox = txt;
    });
  }
  void onCheck (bool? value) {
        setState(() {
          isChecked = value!;
        });
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MyDrawer(isCheck: isChecked,checkCallback: onCheck, txtCallback:  onTextChange,),
      // ignore: avoid_unnecessary_containers
      body: Center(
          child: SizedBox(
            width: 200,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  <Widget>[
                ToastElevatedButton(textBox == ""?"Texte vide":textBox),
                RandomToastElevatedButton(nbWord: isChecked?2:1,),
                
              ],
            ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _changeButtonLabel,
        tooltip: 'Increment',
        label: const Text('Génerer un nouveau bouton'),
        icon: const Icon(Icons.cached),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyDrawer extends StatelessWidget {
  final bool isCheck;
  final ValueChanged<bool?>? checkCallback;
  final ValueChanged<String>? txtCallback;
  const MyDrawer({ Key? key, this.isCheck = false, this.checkCallback, this.txtCallback }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
              ),
              child: const Text('Examen 1'),
          ),
          Center(
            child: SizedBox(
              width: 200,
              child: Column(
                children: [
                  Column(
                    children: [
                      const Text("Nouveau texte pour Bouton #1:"),
                      TextField(
                        onChanged: txtCallback,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: isCheck, onChanged: checkCallback),
                      const Text("Doubler Bouton #2")
                    ],
                  )   
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RandomToastElevatedButton extends ToastElevatedButton{
  final int nbWord;
  RandomToastElevatedButton({Key? key, this.nbWord = 1}):
    super(
      generateWordPairs().take(nbWord).map((e) => e.asPascalCase).join(" "), 
      key: key);
}

class ToastElevatedButton extends StatelessWidget {
  final String text;
  const ToastElevatedButton(this.text,{ Key? key }) :
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text),
      onPressed: (){
        var snackBar = SnackBar(content: Text(text));
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackBar);
      },
    );
  }
}
