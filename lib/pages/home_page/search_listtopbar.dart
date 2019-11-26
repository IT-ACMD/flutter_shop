import 'package:flutter/material.dart';

class SearchListTopBarTitleWidget extends StatelessWidget {
  final String keyworld;
  SearchListTopBarTitleWidget({Key key, this.keyworld}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 34,
        padding: EdgeInsets.only(left: 10),
        margin: EdgeInsets.only(right: 30),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Color.fromRGBO(245, 245, 245, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Color.fromRGBO(51, 51, 51, 1),
                  size: 20,
                ),
                Text(
                  keyworld,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            )));
  }
}
