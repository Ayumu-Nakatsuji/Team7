import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Editor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  final picker = ImagePicker();
  List<Offset> points = <Offset>[];
  Color penColor = Colors.black;
  double penSize = 5.0;
  bool isErasing = false;

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        points = [];
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        points = [];
      }
    });
  }

  void saveImage() async {
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('画像がありません')),
      );
      return;
    }

    try {
      final result = await image!.copy(
        '${Directory.systemTemp.path}/image.png',
      );

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

  void _startDrawing(DragStartDetails details) {
    setState(() {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset point = box.globalToLocal(details.globalPosition);
      points = List.from(points)..add(point);
    });
  }

  void _updateDrawing(DragUpdateDetails details) {
    setState(() {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset point = box.globalToLocal(details.globalPosition);
      points = List.from(points)..add(point);
    });
  }

  void _stopDrawing() {
    setState(() {
      points.add(Offset.infinite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Editor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                getImageFromCamera();
              },
              child: const Text('カメラから画像を取得'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                getImageFromGallery();
              },
              child: const Text('アルバムから画像を取得'),
            ),
            const SizedBox(height: 20),
            if (image != null)
              GestureDetector(
                onPanStart: (details) => _startDrawing(details),
                onPanUpdate: (details) => _updateDrawing(details),
                onPanEnd: (details) => _stopDrawing(),
                child: CustomPaint(
                  painter: ImageEditorPainter(
                    image: image!,
                    points: points,
                    penColor: penColor,
                    penSize: penSize,
                    isErasing: isErasing,
                  ),
                  child: Container(
                    height: 400,
                    width: 300,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      penColor = Colors.black;
                      isErasing = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    fixedSize: const Size(50, 50),
                  ),
                  child: const SizedBox(),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      penColor = Colors.red;
                      isErasing = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    fixedSize: const Size(50, 50),
                  ),
                  child: const SizedBox(),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      penColor = Colors.green;
                      isErasing = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    fixedSize: const Size(50, 50),
                  ),
                  child: const SizedBox(),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      penColor = Colors.blue;
                      isErasing = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    fixedSize: const Size(50, 50),
                  ),
                  child: const SizedBox(),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isErasing = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: const Size(50, 50),
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: const Icon(Icons.delete, color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {
                    saveImage();
                  },
                  child: const Text('画像を保存'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageEditorPainter extends CustomPainter {
  final File image;
  final List<Offset> points;
  final Color penColor;
  final double penSize;
  final bool isErasing;

  ImageEditorPainter({
    required this.image,
    required this.points,
    required this.penColor,
    required this.penSize,
    required this.isErasing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final imageRect = Offset.zero & size;
    final imageProvider = FileImage(image);
    imageProvider.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((info, _) {
        canvas.drawImageRect(
          info.image,
          imageRect,
          imageRect,
          Paint(),
        );
      }),
    );

    Paint paint = Paint()
      ..color = penColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = penSize;

    if (isErasing) {
      paint.blendMode = BlendMode.clear;
    }

    for (int i = 1; i < points.length; i++) {
      if (points[i - 1].dx.isFinite && points[i].dx.isFinite) {
        canvas.drawLine(points[i - 1], points[i], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// import 'package:flutter/material.dart';
// import 'package:team7/MyHomepage.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Team7 prototype'),
//     );
//   }
// }
