import 'package:flutter/material.dart';

class test_page extends StatefulWidget {
  @override
  State<test_page> createState() => _test_pageState();
}

class _test_pageState extends State<test_page> {
  //画像の状態をtrueに設定
  bool _showFirstImage = true;
  //正解した回数
  int rightNumber = 0;
  //間違えた回数
  int wrongNumber = 0;
  //

  //画像の状態を変更
  void _switchImage() {
    setState(() {
      _showFirstImage = !_showFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Column(
        children: <Widget>[
          //画像を表示
          Center(
            child: _showFirstImage
                //TODO:画像の名前を受け取り、表示する(pngのところと入れ替え)
                ? Image.asset('images/sample.jpg', fit: BoxFit.fill)
                : Image.asset('images/test1.png', fit: BoxFit.fill),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          //正解したときに押すボタン
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () {
                              setState(() {
                                rightNumber++;
                              });
                            },
                            child: const Text(
                              '正解した！',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          //正解ボタンを押した回数を表示
                          Container(
                            child: Text(
                              '$rightNumber',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 50,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          //間違えたときに押すボタン
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              setState(() {
                                wrongNumber++;
                              });
                            },
                            child: const Text(
                              '間違えた…',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          //間違いボタンを押した回数
                          Container(
                            child: Text(
                              '$wrongNumber',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _switchImage,
        tooltip: 'Switch Image',
        child: Icon(Icons.swap_horiz),
      ),
    );
  }
}
