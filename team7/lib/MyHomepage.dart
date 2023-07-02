import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'secondPage.dart';

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
        image = File(pickedFile.path);
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
        image = File(pickedFile.path);
      }
    });
  }

  ElevatedButton _sendbutton() {
    if (image == null) {
      return ElevatedButton(
        child: Text(
          'save image',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey)),
        onPressed: () {},
      );
    } else {
      return ElevatedButton(
        child: Text(
          'save image',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
        onPressed: () {
          setState(() {
            _saveImage(image);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SecondPage()));
          });
        },
      );
    }
  }

  Future _saveImage(File? image) async {
    final String newPath = (await getApplicationDocumentsDirectory()).path;
    final imagePath = '$newPath/image.png';
    if (image != null) {
      try {
        final result = await image!.copy(imagePath);

        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('画像が保存されました')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('画像の保存に失敗しました')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('画像の保存に失敗しました')),
        );
      }
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
                    child: Text("画像が選択されていません",
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
                child: _sendbutton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
