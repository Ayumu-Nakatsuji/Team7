import 'package:flutter/material.dart';

class test_page extends StatefulWidget {

  @override
  State<test_page> createState() => _test_pageState();
}

class _test_pageState extends State<test_page> {

  //正解した回数
  int rightNumber = 0;
  //間違えた回数
  int wrongNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('test'),
      ),
      body: Column(
        children: <Widget>[
          //TODO:画像の表示と押すと回答が出るWidgetをここに入れる
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:<Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          //正解したときに押すボタン
                          TextButton(
                            style: TextButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: (){
                              setState(() {
                                rightNumber ++;
                              });
                            },
                            child: Text(
                                '正解した！'
                            ),
                          ),
                          //正解ボタンを押した回数を表示
                          Container(
                            child: Text(
                              '$rightNumber',
                              textAlign:TextAlign.center,
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
                            style: TextButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: (){
                              setState(() {
                                wrongNumber ++;
                              });
                            },
                            child: Text(
                              '間違えた…',
                            ),
                          ),
                          //間違いボタンを押した回数
                          Container(
                            child: Text(
                              '$wrongNumber',
                              textAlign:TextAlign.center,
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
    );
  }
}