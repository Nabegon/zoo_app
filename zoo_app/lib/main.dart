import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiergarten Sammelalbum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyAppGridView(title: 'Tiergarten Sammelalbum'),
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
  List<XFile?> _images = List.filled(30, null);
  final ImagePicker _picker = ImagePicker();

  final List<String> names = [
    'Zweifarbtamarin',
    'Zwergseiden- äffchen',
    'Witwenpfeifganse',
    'Przewalski-Pferd',
    'Jochberger Hummel',
    'Poitou-Esel',
    'Ouessantschaf',
    'Owambo-Ziege',
    'Meerschweinchen',
    'Meißner Widder',
    'Kurzohr-Rüsselspringer',
    'Jakobschaf',
    'Großer Mara',
    'Coburger Fuchsschaf',
    'Südafrikanischer Blauhalsstrauß',
    'Buntes Bentheimer Schwein',
    'Barnevelder Huhn',
    'Spaltenschildkröte',
    'Alpaka',
    'Roter Panda',
    'Lisztaffe',
    'Südliches Kugelgürteltier',
    'Zwergotter',
    'Weißschwanz-Stachelschwein',
    'Lama',
    'Westafrikanische Zwergziege',
    'Polarfuchs',
    'Erdmännchen',
    'Weißkopfseeadler',
    'Streifenskunk',
    'Trampeltier',
    'Schneeeule',
    'Nachtreiher',
    'Frettchen',
    'Bulgarische schraubenhörnige Langhaarziege',
    'Bentheimer Landschaf',
    'Mäusebussard',
    'Europäischer Damhirsch',
    'Blauer Pfau',
    'Österreich-ungarischer weißer Barockesel'
  ];

  Future pickImage(int index) async {
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _images[index] = selectedImage;
    });
  }

  Future<void> shareImage(int index) async {
    try {
      if (_images[index] != null) {
        final File imageFile = File(_images[index]!.path);
        await Share.shareFiles([imageFile.path], mimeTypes: ['image/png']);
      } else {
        print('No image selected');
      }
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
        backgroundColor: Color(0xFF640000),
        //backgroundColor: Color(0xfff47b20),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: 30,
        // SliverGridDelegateWithFixedCrossAxisCount class. Creates grid layouts with a fixed number of tiles in the cross axis
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: _images[index] != null ? () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Image.file(File(_images[index]!.path)),
                actions: <Widget>[
                  TextButton(
                    child: Text('Schließen'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ) : () => pickImage(index), // Only works if no image
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xff640000),
                  width: 3,
                ),
                image: _images[index] != null ? DecorationImage(
                  image: FileImage(File(_images[index]!.path)),
                  fit: BoxFit.cover,
                ) : null,
              ),
              child: Stack(
                children: <Widget>[
                  Center(child: _images[index] != null ? Text(" ") : Icon(Icons.photo_camera, color: Colors.grey, size: 70,),),
                  Positioned(
                    bottom: 2,
                    left: 5,
                    child: _images[index] != null ? IconButton(
                      icon: Icon(Icons.photo_camera, color: Color(0xFF640000), size: 40,),
                      onPressed: () => pickImage(index),
                    ) : Container(),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        shareImage(index);
                      },
                      child: Icon(Icons.share, color: Color(0xFF640000), size: 40,),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
