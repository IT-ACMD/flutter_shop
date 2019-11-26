import 'package:flutter/material.dart';

///
/// 这是一个自定义的选择性别的弹窗
///
class AppTitleBar extends StatelessWidget {
  String title = '';
  double size = 18.0;

  AppTitleBar({Key key, @required this.title, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover)),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Row(
              children: <Widget>[
                Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      child: Image.asset(
                        'images/arrow_left.png',
                        height: 24.0,
                        width: 30.0,
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: this.size,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    padding: EdgeInsets.only(left: 11.0),
                  ),
                ),
                InkWell(
                  child: Image.asset(
                    'images/message.png',
                    height: 35.0,
                    width: 35.0,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      //return NewsPage();
                    }));
                  },
                ),
              ],
            )
          ],
        ));
  }
}

//home页面专属
class AppTitleBarH extends StatelessWidget {
  String title = '';

  AppTitleBarH({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover)),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Row(
              children: <Widget>[
                Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      child: Image.asset(
                        'images/navigate.png',
                        height: 35.0,
                        width: 35.0,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  child: Image.asset(
                    'images/message.png',
                    height: 35.0,
                    width: 35.0,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      //return NewsPage();
                    }));
                  },
                ),
              ],
            )
          ],
        ));
  }
}
