//这是闪屏动画页面
import 'package:flutter/material.dart';

import 'pages/home_page/Index.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
          return Index();
        }), (route) => route == null);
      }
    });
    _controller.forward(); //播放动画
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.asset(
        'images/splash_screen.png',
        //'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1570617373504&di=b58276a337210c7f56cbd4ab26fb2eed&imgtype=0&src=http%3A%2F%2Fwx2.sinaimg.cn%2Fcrop.0.0.1797.1009.1000%2F005NLzplly1fvf2rfe838j31jm0s2gv8.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
