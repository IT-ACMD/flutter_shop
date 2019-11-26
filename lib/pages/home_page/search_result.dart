import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page/search_page.dart';

class SearchResultListWidget extends StatelessWidget {
  final SearchResultListModal list;
  final ValueChanged<String> onItemTap;
  final VoidCallback getNextPage;
  SearchResultListWidget(this.list, {this.onItemTap, this.getNextPage});
  @override
  Widget build(BuildContext context) {
    return list.data.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: list.data.length,
            //itemExtent: ScreenUtil().L(127),
            itemBuilder: (BuildContext context, int i) {
              SearchResultItemModal item = list.data[i];
              if ((i + 3) == list.data.length) {
                getNextPage();
              }
              return Container(
                color: Color(0xFFFFFFFF),
                padding: EdgeInsets.only(top: 5, right: 10),
                child: Row(
                  children: <Widget>[
                    Image.network(
                      item.imageUrl,
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(245, 245, 245, 1.0)))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.wareName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '￥${item.price}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(182, 9, 9, 1.0)),
                              ),
                              item.coupon == null
                                  ? SizedBox()
                                  : Container(
                                      child: Text(
                                        item.coupon,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                132, 95, 63, 1.0)),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      margin: EdgeInsets.only(left: 4),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  132, 95, 63, 1.0))),
                                    )
                            ],
                          ),
                          Text(
                            '${item.commentcount}人评价 好评率${item.good}%',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF999999)),
                          ),
                          Text(
                            '${item.shopName}',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF999999)),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              );
            },
          );
  }
}
