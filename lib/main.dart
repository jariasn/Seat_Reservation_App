import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
          title: 'Reservas parroquia v1',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the app home page. It has a State object that contains fields that affect
  // how it looks (as it's stateful).

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
//createState() returns _MyHomePageState

}

class _MyHomePageState extends State<MyHomePage> {
  final fb = FirebaseDatabase.instance;
  //using FirebaseDatabase.instance we get an instance of Firebase
  final myController = TextEditingController();
  //We create an instance of TextEditingController that will be used
  // to retrieve the text from the TextField.
  final name = "Name";
  var retrievedName;

  @override
  Widget build(BuildContext context) {
    // This method is run every time setState is called.
    final ref = fb.reference();
    //Here we call the method reference() that will return a DatabaseReference
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(name),
                Flexible(child: TextField(controller: myController)),
              ],
            ),
            RaisedButton(
              onPressed: () {
                ref.child(name).set(myController.text);
                //with this, we create an attribute in the database
                // with the value of TextField
              },
              child: Text('Reservar'),
            ),
            RaisedButton(
              onPressed: () {
                ref.child("Name").once().then((DataSnapshot data){
                  print(data.value);
                  //We use value to retrieve the content of the DataSnapshot.
                  print(data.key);
                  //We use key to retrieve the location of this dataSnapshot
                  //(it will return the attribute Name).
                  setState(() {
                    retrievedName = data.value;
                  });
                });
              },
              child: Text("Obtener lista de personas que han reservado"),
            ),
            Text(retrievedName ?? "name"),
        ],
        ),
      ),
    );
}

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}

