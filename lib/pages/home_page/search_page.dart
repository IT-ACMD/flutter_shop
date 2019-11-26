import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:flutter_app/data/dataCenter.dart';

import 'search_listtopbar.dart';
import 'search_result.dart';
import 'search_topbar.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List hotWords = [];
  List<String> recomendWords = [];
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Color(0xFFFFFFFF),
          leading: SearchTopBarLeadingWidget(),
          actions: <Widget>[
            SearchTopBarActionWidget(
              onActionTap: () => goSearchList(controller.text),
            )
          ],
          elevation: 0,
          titleSpacing: 0,
          title: SearchTopBarTitleWidget(
            seachTxtChanged: seachTxtChanged,
            controller: controller,
          )),
      body: recomendWords.length == 0 ? hotSugWidget() : recomendListWidget(),
    );
  }

  recomendListWidget() {
    var items = recomendWords;
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int i) {
        return InkWell(
          onTap: () => goSearchList(items[i]),
          child: Container(
            height: 42,
            width: double.infinity,
            // color: Colors.red,
            alignment: Alignment.centerLeft,
            // constraints: BoxConstraints(minWidth: double.infinity),
            child: Text(
              items[i],
              style: TextStyle(fontSize: 15),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Container(
          height: 1,
          color: Color(0xFFdedede),
        );
      },
    );
  }

  hotSugWidget() {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          color: Color.fromRGBO(245, 245, 245, 1.0),
          child: Text('热门搜索'),
          margin: EdgeInsets.only(bottom: 10),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: hotWords
              .map((i) => GestureDetector(
                    onTap: () => goSearchList(i),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                        .toInt() <<
                                    0)
                                .withOpacity(1.0),
                            borderRadius: BorderRadius.circular(5)),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                        child: Text(
                          i,
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        )),
                  ))
              .toList(),
        )
      ],
    );
  }
  
  void initData() async {
    /*List querys = await getHotSugs();
    setState(() {
      hotWords = querys;
    });*/
  }

  onSearchBtTap() {
    if (controller.text.trim().isNotEmpty) {
      goSearchList(controller.text);
    }
  }

  void seachTxtChanged(String q) async {
    /*var result = await getSuggest(q) as List;
    recomendWords = result.map((dynamic i) {
      List item = i as List;
      return item[0] as String;
    }).toList();
    setState(() {});*/
  }

  goSearchList(String keyWord) {
    if (keyWord.trim().isNotEmpty) {
      Navigator.push(context,
          CupertinoPageRoute(builder: (BuildContext context) {
        return SearchResultListPage(keyWord);
      }));
    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }
}

class SearchResultListPage extends StatefulWidget {
  final String keyword;
  SearchResultListPage(this.keyword);

  @override
  State<StatefulWidget> createState() => SearchResultListState();
}

class SearchResultListState extends State<SearchResultListPage> {
  SearchResultListModal listData = SearchResultListModal([]);
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Color(0xFFFFFFFF),
            leading: SearchTopBarLeadingWidget(),
            //  actions: <Widget>[SearchTopBarActionWidget()],
            elevation: 0,
            titleSpacing: 0,
            title: SearchListTopBarTitleWidget(keyworld: widget.keyword)),
        body: SearchResultListWidget(listData,
            getNextPage: () => getSearchList(widget.keyword)));
  }

  void getSearchList(String keyword) async {
    /*var data = await getSearchResult(keyword, page++);
    SearchResultListModal list = SearchResultListModal.fromJson(data);
    setState(() {
      listData.data.addAll(list.data);
    });*/
  }

  @override
  void initState() {
    getSearchList(widget.keyword);
    super.initState();
  }
}

class SearchResultItemModal {
  String shopName;
  String wareName;
  String price;
  String coupon;
  String imageUrl;
  String commentcount;
  String good; //好评率
  String shopId;
  String disCount;
  SearchResultItemModal(
      {this.shopId,
      this.shopName,
      this.commentcount,
      this.coupon,
      this.price,
      this.good,
      this.disCount,
      this.imageUrl,
      this.wareName});
  factory SearchResultItemModal.fromJson(dynamic json) {
    String picurl = 'http://img10.360buyimg.com/mobilecms/s270x270_' +
        json['Content']['imageurl'];
    String coupon;
    if (json['coupon'] != null) {
      if (json['coupon']['m'] != '0') {
        coupon = '满${json['coupon']['m']}减${json['coupon']['j']}';
      }
    }
    String disCount;
    if (json['pfdt'] != null) {
      if (json['pfdt']['m'] != '') {
        disCount = '${json['pfdt']['m']}件${json['pfdt']['j']}折';
      }
    }

    return SearchResultItemModal(
        shopId: json['shop_id'],
        shopName: json['shop_name'],
        imageUrl: picurl,
        good: json['good'],
        commentcount: json['commentcount'],
        price: json['dredisprice'],
        coupon: coupon,
        disCount: disCount,
        wareName: json['Content']['warename']);
  }
}

class SearchResultListModal {
  List<SearchResultItemModal> data;
  SearchResultListModal(this.data);
  factory SearchResultListModal.fromJson(List json) {
    return SearchResultListModal(
        json.map((i) => SearchResultItemModal.fromJson(i)).toList());
  }
}
