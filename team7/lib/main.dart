import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Team7 prototype'),
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
  final ImagePicker picker = ImagePicker();
  File? image;

  Future _getPicture() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery); //カメラから画像を取得
    setState(() {
      //画面を再読込
      if (pickedFile != null) {
        //画像を取得できたときのみ実行
        image = File(pickedFile.path); //取得した画像を代入
      }
    });
  }

  Future _getPictureCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera); //カメラから画像を取得
    setState(() {
      //画面を再読込
      if (pickedFile != null) {
        //画像を取得できたときのみ実行
        image = File(pickedFile.path); //取得した画像を代入
      }
    });
  }

  TextButton _sendbutton() {
    if (image == null) {
      return TextButton(
        child: Text(
          'save image',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey)),
        onPressed: () {},
      );
    } else {
      return TextButton(
        child: Text(
          'save image',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
        onPressed: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: FloatingActionButton(
                      onPressed: _getPictureCamera,
                      child: const Icon(
                        Icons.camera_alt,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(width: 100),
                  Container(
                    width: 80,
                    height: 80,
                    child: FloatingActionButton(
                      onPressed: _getPicture,
                      child: const Icon(
                        Icons.image,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            //nullのときはText表示、nullでないときはContainer表示
            image == null
                ? Container(
                    color: Colors.grey[200],
                    height: 400,
                    width: 200, //画像の高さを設定//画像の幅を設定
                    child: Text('画像が選択されていません',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)), //画像を表示
                  )
                : Container(
                    //三項演算子
                    height: 400,
                    width: 200,
                    child: Image.file(image!, fit: BoxFit.cover), //画像を表示
                  ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(70),
                child: SizedBox(height: 30, child: _sendbutton()),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _getPicture,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
