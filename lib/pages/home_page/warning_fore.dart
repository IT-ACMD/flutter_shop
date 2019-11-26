import 'package:flutter/material.dart';

class WarningFore extends StatefulWidget {
  @override
  _WarningForeState createState() => _WarningForeState();
}

class _WarningForeState extends State<WarningFore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Color(0xfff5f5f5),
        child: ListView(
          children: <Widget>[
            buildParams(),
          ],
        ),
      ),
    );
  }

  buildBackbutton() {
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
      Text('预警信息',
          style: TextStyle(
              fontSize: 20.0,
              color: Color(0xff333333),
              fontWeight: FontWeight.bold)),
    ]);
  }

  getColorOrtext(status, type) {
    if (status == 1) {
      if (type == 'tcolor')
        return Color(0xff24c789);
      else if (type == 'bcolor')
        return Color(0xffe9f9f3);
      else if (type == 'text') return '正常';
    } else {
      if (type == 'tcolor')
        return Color(0xffee7029);
      else if (type == 'bcolor')
        return Color(0xffffefe6);
      else if (type == 'text') return '低';
    }
  }

  buildParams() {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(9.0))),
      child: Column(
        children: List.generate(5, (i) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 18.0),
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
                        text: 'value',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xff24c789),
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'unit\n',
                              style: TextStyle(fontSize: 12.0),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'typeName',
                                    style: TextStyle(color: Color(0xff999999)))
                              ])
                        ]),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 22.0,
                        width: 58.0,
                        alignment: Alignment.center,
                        child: Text(
                          'res',
                          style: TextStyle(
                              color: getColorOrtext(
                                  'status', 'tcolor')),
                        ),
                        color: getColorOrtext('res', 'bcolor'),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'creatTime',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 10.0, color: Color(0xffcccccc)),
                          ))
                    ],
                  )
                ],
              ));
        }),
      ),
    );
  }
}
