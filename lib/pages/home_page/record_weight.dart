import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class RecordWeight extends StatefulWidget {
  @override
  _RecordWeightState createState() => _RecordWeightState();
}

class _RecordWeightState extends State<RecordWeight>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  //Animation<int> animation;
  //AnimationController _controller;
  //double _scale = 0;
  //int _userRate = 0;
  int _battleAchievements = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
      color: Colors.white,
      child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildtitletext(),
              buildIndicator(),
              buildRecordButton(),
              buildHistoryRecords()
            ],
          )),
    ));
  }

  Widget buildBackButton(context) {
    return Row(children: <Widget>[
      IconButton(
        padding: EdgeInsets.all(0.0),
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 28,
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      Text('体重记录',
          style: TextStyle(
            fontSize: 20.0,
            color: Color(0xff333333),
          )),
    ]);
  }

  buildtitletext() {
    return Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Text(
          '单位：公斤',
          style: TextStyle(color: Color(0xff999999), fontSize: 13.0),
          textAlign: TextAlign.right,
        ));
  }

  buildIndicator() {
    return UnconstrainedBox(
        child: Container(
      child: CustomPaint(
        painter: DemoPainter(pi * 3 / 4, 0), //_controller.value * _scale),
        child: Container(
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: '比原来轻\n',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: '$_battleAchievements\n',
                        style: TextStyle(
                            fontSize: 48.0,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: '减肥/减脂',
                              style: TextStyle(
                                  fontSize: 12.0, color: Color(0xff999999)))
                        ])
                  ]),
            )),
      ),
      height: 234.0,
      width: 234.0,
      padding: EdgeInsets.all(30.0),
    ));
  }

  void _showDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return Container(
              alignment: Alignment.center,
              child: Text(
                '请输入当前体重',
                style: TextStyle(color: Color(0xFF333333), fontSize: 17.0),
              ));
        }).then((value) {
      //保存到本地
      if (value == null) return;
      RecordWeightData rw = RecordWeightData();
      //rw.weightVal = value.toString();
      //rw.type = '初始体重';
      DateTime date = DateTime.now();
      //rw.creatTime = formatDate(date, [yyyy, '-', mm, '-', dd]).toString();
    });
  }

  buildRecordButton() {
    return UnconstrainedBox(
        child: Container(
            margin: EdgeInsets.only(bottom: 32.0),
            width: 175.0,
            height: 44.0,
            child: RaisedButton(
              child: Text('记录体重',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          16.0) //Theme.of(context).primaryTextTheme.headline,
                  ),
              color: Color.fromARGB(255, 36, 199, 137),
              onPressed: () {
                _showDialog();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      24.0)), //StadiumBorder(side: BorderSide()),
            )));
  }

  buildHistoryRecords() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Color(0xfff4f4f4), width: 2.0))),
        child: Column(
            children: List.generate(2, (i) {
          return Padding(
              padding: EdgeInsets.only(top: 21.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'sadasd',
                        style: TextStyle(
                            fontSize: 21.0,
                            color: Color(0xff524d55),
                            fontWeight: FontWeight.bold,
                            height: 1.5),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' 公斤\n',
                              style: TextStyle(fontSize: 12.0),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '普通',
                                    style: TextStyle(color: Color(0xff999999)))
                              ])
                        ]),
                  ),
                  RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                        text: '开始减肥/减脂\n',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff999999),
                            height: 2.0),
                        children: <TextSpan>[
                          TextSpan(
                            text: '2012',
                          )
                        ]),
                  ),
                ],
              ));
        })));
  }
}

class RecordWeightData {
}

//重绘环形
class DemoPainter extends CustomPainter {
  final double _arcStart;
  final double _arcSweep;

  DemoPainter(this._arcStart, this._arcSweep);

  @override
  void paint(Canvas canvas, Size size) {
    double side = min(size.width, size.height);
    Paint paint = Paint()
      ..color = Color(0xFFF7F7F7)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Offset.zero & Size(side, side), 0.0, pi * 2, false, paint);
    paint.color = Color(0xFF22C487);
    //canvas.drawArc(
    //Offset.zero & Size(side, side), _arcStart, _arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(DemoPainter other) {
    return _arcStart != other._arcStart || _arcSweep != other._arcSweep;
  }
}

addRecordData(val) async {
}