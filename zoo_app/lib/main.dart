import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '7 Sterne',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '7 Sterne'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: DefaultTextStyle( // Used DefaultTextStyle
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30), // Made title bold
            child: Text(title),
          ),
        centerTitle: true,
        backgroundColor: Color(0xfff47b20),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: 30,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: Color(0xff640000),
                  width: 3,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Center(child: Text("Name?", style: TextStyle(color: Color(0xff640000)))),
                Positioned( // added Positioned
                  top: 5, // from top 5
                  right: 5, // from right 5
                  child: Icon(Icons.star, color: Colors.grey, size: 40,),
                ),
                Positioned( // added Positioned
                  bottom: 5, // from bottom 5
                  left: 5, // from left 5
                  child: Icon(Icons.add_a_photo, color: Color(0xfff47b20), size: 40,), // added add_a_photo Icon
                ),
                Positioned( // added Positioned
                  bottom: 3, // from bottom 5
                  left: 45, // from left 5
                  child: Icon(Icons.add_comment, color: Color(0xfff47b20), size: 40,), // added add_a_photo Icon
                ),
                Positioned( // added Positioned
                  bottom: 12, // from bottom 5
                  left: 80, // from left 5
                  child: Icon(Icons.question_mark, color: Color(0xfff47b20), size: 30,), // added add_a_photo Icon
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
