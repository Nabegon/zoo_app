import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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
      home: const MyAppGridView(title: '7 Sterne'),
    );
  }
}

class MyAppGridView extends StatefulWidget {
  const MyAppGridView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyAppGridViewState createState() => _MyAppGridViewState();
}

class _MyAppGridViewState extends State<MyAppGridView> {
  Future<void> shareImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageFile = await File('${directory.path}/my_image.png').create();
      await imageFile.writeAsBytes((await rootBundle.load('assets/images/my_image.png')).buffer.asUint8List());
      await Share.shareFiles([imageFile.path], mimeTypes: ['image/png']);
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DefaultTextStyle(
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30), // Made title bold
          child: Text(widget.title),
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
              image: index == 0 ? DecorationImage(
                image: AssetImage('assets/images/my_image.png'),
                fit: BoxFit.cover,
              ) : null,
            ),
            child: Stack(
              children: <Widget>[
                Center(child: index == 0 ? Text(" ") : Text("Name?", style: TextStyle(color: Color(0xff640000)))),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(Icons.star, color: index == 0 ? Colors.yellow : Colors.grey, size: 40,),
                ),
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: Icon(Icons.add_a_photo, color: Color(0xfff47b20), size: 40,),
                ),
                Positioned(
                  bottom: 3,
                  left: 45,
                  child: InkWell(
                    onTap: () {
                      if (index == 0) {
                        shareImage();
                      }
                    },
                    child: Icon(Icons.add_comment, color: Color(0xfff47b20), size: 40,),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 80,
                  child: Icon(Icons.question_mark, color: Color(0xfff47b20), size: 30,),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
