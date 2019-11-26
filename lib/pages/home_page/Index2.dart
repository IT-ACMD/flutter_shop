import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widget/title_barA.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'search_page.dart';

class Index extends StatefulWidget {
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  // 插件提供的对象，该对象用于WebView的各种操作
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  //WebView加载失败
  StreamSubscription<WebViewHttpError> _onhttpError;
  // On destroy stream
  StreamSubscription _onDestroy;
  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;
  // 标记当前页面是否是我们自定义的回调页面
  bool isLoadingCallbackPage = false;
  //当前加载页面
  String selectedUrl =
      'https://www.tinhtinh.com.kh/'; //'htttp://www.baidu.com';//
  //网络错误加载页
  String errorUrl;
  // 标记是否是加载中
  bool loading = false;
  //头部
  String titleStr = 'Home';

  Stream<ConnectivityResult> connectChangeListener() async* {
    final Connectivity connectivity = Connectivity();
    await for (ConnectivityResult result
        in connectivity.onConnectivityChanged) {
      yield result;
    }
  }

  String _connectionStatus = 'Unknown';
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _history = [];

  int _nowindex = 0;

  Color itemOne = Colors.blue;
  Color itemTwo = Colors.grey;

  @override
  void initState() {
    super.initState();
    //获取本地404页面
    _getFile();
    //网络状态舰艇
    _connectivitySubscription =
        connectChangeListener().listen((ConnectivityResult result) {
      if (!mounted) {
        return;
      }
      setState(() => _connectionStatus = result.toString());
    });
    //webview路径监听
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {});
    //webview加载失败
    _onhttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError e) {
      loading = false;
      setState(() {});
    });
    //webview状态变化
    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      // state.type是一个枚举类型，取值有：WebViewState.shouldStart, WebViewState.startLoad, WebViewState.finishLoad
      switch (state.type) {
        case WebViewState.shouldStart:
          // 准备加载
          //parseResult();
          break;
        case WebViewState.startLoad:
          // 开始加载
          //loading = true;
          //loadingAnimation();
          break;
        case WebViewState.finishLoad:
          // 加载完成
          loading = false;
          setState(() {});
          parseResult();
          break;
        case WebViewState.abortLoad:
          // TODO: Handle this case.
          loading = false;
          break;
      }
    });
    //flutterWebViewPlugin.launch(selectedUrl);
  }

  @override
  void dispose() {
    // 回收相关资源
    _connectivitySubscription.cancel();
    //_onDestroy.cancel();
    _onhttpError.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  // 解析WebView中的数据
  void parseResult() {
    if (titleStr == "Home") {
      flutterWebViewPlugin
          .evalJavascript("\$(\".tabBar\").css('display','none');");
    }
  }

  //获取本地404页面
  _getFile() async {
    String urlcontent = await rootBundle.loadString('assets/networkerror.html');
    errorUrl = Uri.dataFromString(urlcontent,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus != "ConnectivityResult.wifi" &&
        _connectionStatus != "ConnectivityResult.mobile" &&
        _connectionStatus != "Unknown") {
      selectedUrl = errorUrl;
    }
    Widget load = Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
    Widget child = WebView(
      initialUrl: 'https://flutterchina.club/', //selectedUrl, // 加载的url
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController web) {
        // webview 创建调用，
        web.loadUrl(selectedUrl);
        web.canGoBack().then((res) {
          print(res); // 是否能返回上一级
        });
        web.currentUrl().then((url) {
          print(url); // 返回当前url
        });
        web.canGoForward().then((res) {
          print(res); //是否能前进
        });
      },
      onPageFinished: (String value) {
        // webview 页面加载调用
      },
    );

    List<Widget> widgetList = [];
    widgetList.add(child);
    //如果正在加载，则显示加载添加加载中布局
    if (loading) {
      /*widgetList.add(
        Opacity(
            opacity: 0.8,
            child: ModalBarrier(
              color: Colors.white,
            )),
      );*/
      widgetList.add(load);
    }
    return Scaffold(
      appBar: AppBarA(
        child: searchButtonBar(),
      ), //AppBar(title: Text(titleStr)),

      body: loading ? load : child, //Stack(children: widgetList), //
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xffc74f3a),
        unselectedItemColor: Colors.grey,
        currentIndex: _nowindex,
        items: [
          BottomNavigationBarItem(
            //具体的菜单按钮元素
            icon: Icon(Icons.home), //设置图标,和颜色
            title: Text("Home", style: TextStyle(fontSize: 14.0)), //设置文字和颜色
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_download),
            title: Text("Download", style: TextStyle(fontSize: 14.0)), //设置文字和颜色
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Cart", style: TextStyle(fontSize: 14.0)), //设置文字和颜色
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(
              "Account",
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: _onRefresh,
      ),
    );
  }

  //点击导航跳转不同路径页面
  Future<Null> _onRefresh(index) {
    if (_nowindex != index) {
      _nowindex = index;
      if (_nowindex == 0) {
        titleStr = "Home";
        selectedUrl = "https://www.tinhtinh.com.kh/";
      } else if (_nowindex == 1) {
        titleStr = "Download";
        selectedUrl =
            "https://www.tinhtinh.com.kh/download/TinhTinh_User_Guide_cn.pdf";
      } else if (_nowindex == 2) {
        titleStr = "Cart";
        selectedUrl = "https://www.tinhtinh.com.kh/shop-car";
      } else if (_nowindex == 3) {
        titleStr = "Account";
        selectedUrl = "https://stagingtpay.tinhtinh.com.kh/user/dashboard";
      }
      loading = true;
      setState(() {});
      flutterWebViewPlugin.reloadUrl(selectedUrl);
      Future.delayed(Duration(seconds: 3), () {
        if (loading) {
          setState(() {
            loading = !loading;
            //Toast.show(context, "加载完成");
          });
        }
      }).then((res) {
        parseResult();
      });
    }
  }

  loadingAnimation() async {
    //await
  }

  _disMissCallBack(Function func) {
    //func();
  }

  searchButtonBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          //FlutterLogo(),
          Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SearchPage();
                  }));
                },
                child: Container(
                  height: 34.0,
                  padding: EdgeInsets.all(5.0),
                  color: Color.fromRGBO(238, 238, 238, 0.5),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF979797),
                          size: 22,
                        ),
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Color(0xFF979797),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6.0),
            child: Icon(
              Icons.add_alert,
              size: 25.0,
              color: Color.fromRGBO(132, 95, 63, 1.0),
            ),
          )
        ],
      ),
    );
  }
}
//动画缓冲
/*showDialog(
                context: context,
                builder: (context) {
                  return new NetLoadingDialog(
                    dismissDialog: _disMissCallBack,
                    outsideDismiss: false,
                  );
                }).then((res) {
              
            });*/
//flutterWebViewPlugin.launch(selectedUrl);
//setState(() {});

/**
 * 底部导航继承的是动态StatefulWidget，注意。
 *
 *
 * Scaffold()组件的
    body ：主体显示组件
    bottomNavigationBar：BottomNavigationBar() 底部菜单导航属性，
 * BottomNavigationBar() 底部导航组件
 * items：设置按钮图标，文字
 * type: BottomNavigationBarType.fixed,//设置按钮类型，固定的
 * currentIndex: _nowindex,//设置当前显示的页面索引
 * onTap:(int index){}   点击响应，一般使用以下语法
    onTap: (int index){//参数设置为默认的index，这个index就是点击的按钮的index
    //setState  这个也是内置方法，只需要将index参数赋值给已设定的属性 _now_index;
    setState(() {
    _nowindex =index;
    });
    },
 *
 * 新建文件，命名方式 是讲类名全部小写，用_连接。例如home_view.dart,其中的主要类就是HomeView
 *
 */
