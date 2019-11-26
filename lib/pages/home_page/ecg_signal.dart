import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class ECGSignal extends StatefulWidget {
  @override
  _ECGSignalState createState() => _ECGSignalState();
}

class _ECGSignalState extends State<ECGSignal>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  double _scale = 0;
  
  int _userRate = 0;
  
  int _maxRate = 150;

  DateTime secondDate = DateTime.now();
  
  DateTime firstDate;

  @override
  void initState() {
    super.initState();
    //获取用户数据
    _userRate = 89;
    _scale = _userRate / _maxRate * pi * 2;
    firstDate = secondDate.subtract(new Duration(days: 6));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
          color: Color.fromARGB(255, 82, 77, 85),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                buildDatePicker(),
                buildGraphwithDay(),
                buildSignalText(),
                Container(
                  color: Color(0xFFF4F4F4),
                  child: SizedBox(
                    height: 8.0,
                  ),
                ),
                buildParams(),
              ],
            ),
          ),
        ));
  }

  Widget buildBackButton(context) {
    return Row(children: <Widget>[
      IconButton(
        padding: EdgeInsets.all(0.0),
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 28,
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      Text('心电信号',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          )),
    ]);
  }

  buildDatePicker() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.all(0.0),
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 28,
            color: Colors.white,
            onPressed: () {
              setState(() {
                firstDate = firstDate.subtract(Duration(days: 7));
                secondDate = secondDate.subtract(Duration(days: 7));
              });
            },
          ),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(
                      color: Color(0xff908c92),
                      fontWeight: FontWeight.bold),
                  text:
                      '${firstDate.year}年${firstDate.month}月${firstDate.day}日 - ${secondDate.year}年${secondDate.month}月${secondDate.day}日\n',
                  children: <TextSpan>[
                    TextSpan(text: '7天 - 心率',)
                  ])),
          IconButton(
            padding: EdgeInsets.all(0.0),
            icon: Icon(Icons.arrow_forward_ios),
            iconSize: 28,
            color: Colors.white,
            onPressed: () {
              setState(() {
                firstDate = firstDate.add(Duration(days: 7));
                secondDate = secondDate.add(Duration(days: 7));
              });
            },
          ),
        ],
      ),
    );
  }

  buildGraphwithDay() {
    return Container(
      height: 214.0,
      //margin: EdgeInsets.fromLTRB(0.0, 13.0, 0.0, 70.0),
    );
  }

  buildSignalText() {
    return Container(
      height: 106.0,
      color: Color(0xffffffff),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1.0, color: Color(0xffdddddd)))),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '56',
                      style: TextStyle(
                          fontSize: 34.0,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: '\n静止心率(BPM)',
                          style: TextStyle(
                              fontSize: 13.0, color: Color(0xff908c92)),
                        ),
                      ],
                    ),
                  ))),
          Expanded(
              child: Container(
                  child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '110',
              style: TextStyle(
                  fontSize: 34.0,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: '\n静止心率(BPM)',
                  style: TextStyle(fontSize: 13.0, color: Color(0xff908c92)),
                ),
              ],
            ),
          ))),
        ],
      ),
    );
  }

  var params = [
    {'name': '能量消耗', 'val': '59.4', 'unit': 'EE'},
    {'name': '氧消耗量', 'val': '59.4', 'unit': 'VO2'},
    {'name': '最大氧消耗', 'val': '59.4', 'unit': 'VO2max'},
    {'name': '运动过后氧消耗', 'val': '59.4', 'unit': 'EPOC'},
    {'name': '训练效果', 'val': '59.4', 'unit': 'TE'}
  ];

  buildParams() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: List.generate(params.length, (i) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 1.0, color: Color(0xfff4f4f4)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    params[i]['name'],
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Color(0xff524d55),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                          text: '${params[i]['val']} ',
                          children: <TextSpan>[
                        TextSpan(
                            text: params[i]['unit'],
                            style: TextStyle(fontSize: 12.0,color: Color(0xff666666)))
                      ]))
                ],
              ));
        }),
      ),
    );
  }
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
    canvas.drawArc(
        Offset.zero & Size(side, side), _arcStart, _arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(DemoPainter other) {
    return _arcStart != other._arcStart || _arcSweep != other._arcSweep;
  }
}

