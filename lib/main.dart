import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/home_page/Index.dart';
import 'package:flutter_app/pages/home_page/search_page.dart';
//引入自定义的其他页面文件
import 'SplashScreen.dart';
import 'data/dataCenter.dart';

main() async {
  runApp(MyApp(true));
  //获取本地404页面
  await _getFile();
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: null,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

//获取本地404页面
_getFile() async {
  String urlcontent = await rootBundle.loadString('assets/networkerror.html');
  errorUrl = Uri.dataFromString(urlcontent,
          mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
      .toString();
}

class MyApp extends StatelessWidget {
  bool _login = true;
  MyApp(bool isNeedLogin) {
    _login = isNeedLogin;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'tinhtinh shop',
        theme: ThemeData(
            primaryColor: Color(0xffc74f3a),
            accentColor: Colors.white), //设置为黑色主题
        home:
            SplashScreen(), //,//BottomMenu(),//这个类在，bottom_menu.dart  中定义。LoginView()
        routes: <String, WidgetBuilder>{
          "search": (BuildContext context) => SearchPage(),
          "index": (BuildContext context) => Index(),
        });
  }
}
