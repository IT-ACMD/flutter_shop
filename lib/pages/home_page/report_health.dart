import 'package:flutter/material.dart';
import 'dart:math';

class HealthReport extends StatefulWidget {
  @override
  _HealthReportState createState() => _HealthReportState();
}

class _HealthReportState extends State<HealthReport> {
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
                buildUserInfo(),
                buildSignalText(),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    height: 11.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF24c789),
                      border: Border(top: BorderSide(width: 1.0)),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(11.0)),
                    )),
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
    ]);
  }

  buildUserInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 17.0, 16.0, 31.0),
      child: Row(
        children: <Widget>[
          ClipOval(
              child: Image.asset(
            "images/user_head.png",
            width: 42,
            height: 42,
          )),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Airplane',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  height: 18.0,
                  child: RaisedButton.icon(
                    icon: ImageIcon(
                      AssetImage('images/diamond.png'),
                      size: 12.0,
                      color: Color.fromARGB(255, 36, 199, 137),
                    ),
                    label: Text(
                      '普通会员',
                      style: TextStyle(fontSize: 10.0, color: Colors.white),
                    ),
                    color: Color(0xff5e5a61),
                    highlightColor: Colors.white, //按下颜色
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: UnconstrainedBox(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 42.0,
                    width: 86.0,
                    //padding: EdgeInsets.only(right: 16.0),
                    child: RaisedButton(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: '健康指数\n',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '90',
                                    style: TextStyle(
                                        fontSize: 19.0,
                                        color: Color(0xff24c789))),
                                TextSpan(
                                    text: '分',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.normal))
                              ])),
                      color: Color(0xff5e5a61),
                      //highlightColor: Colors.white, //按下颜色
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      onPressed: () {},
                    ),
                  )))
        ],
      ),
    );
  }

  buildSignalText() {
    return Container(
        padding: EdgeInsets.only(left: 16.0, bottom: 18.0),
        //color: Color(0xffffffff),
        child: Text(
          '报告指数',
          style: TextStyle(
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
        ));
  }

  var params = [
    {'name': '心率等级', 'val': '90', 'unit': 'bpm', 'status': 1},
    {'name': '体重', 'val': '100', 'unit': '斤', 'status': 1},
    {'name': '体脂率', 'val': '20.9', 'unit': '%', 'status': 1},
    {'name': '脂肪', 'val': '22.2', 'unit': '斤', 'status': 1},
    {'name': '蛋白质', 'val': '15', 'unit': '斤', 'status': 1},
    {'name': '水分', 'val': '63.8', 'unit': '斤', 'status': 1},
    {'name': '肌肉', 'val': '78.6', 'unit': '斤', 'status': 2},
    {'name': '骨骼肌', 'val': '56.6', 'unit': '斤', 'status': 2},
    {'name': '骨质', 'val': '5.2', 'unit': '斤', 'status': 1},
  ];

  getColorOrtext(status, type) {
    if (status == 1) {
      if (type == 'tcolor')return Color(0xff24c789);
      else if (type == 'bcolor')return Color(0xffe9f9f3);
      else if (type == 'text') return '正常';
    } else if (status == 2) {
      if (type == 'tcolor')return Color(0xffee7029);
      else if (type == 'bcolor')return Color(0xffffefe6);
      else if (type == 'text') return '低';
    }
  }

  buildParams() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(9.0))),
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: params[i]['val'],
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xff24c789),
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${params[i]['unit']}\n',
                              style: TextStyle(fontSize: 12.0),
                              children: <TextSpan>[
                                TextSpan(
                                    text: params[i]['name'],
                                    style: TextStyle(color: Color(0xff999999)))
                              ])
                        ]),
                  ),
                  Container(
                    height: 22.0,
                    width: 58.0,
                    alignment: Alignment.center,
                    child: Text(
                      getColorOrtext(params[i]['status'], 'text'),
                      style: TextStyle(color: getColorOrtext(params[i]['status'], 'tcolor')),
                    ),
                    color: getColorOrtext(params[i]['status'], 'bcolor'),
                  )
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
