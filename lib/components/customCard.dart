import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget content;
  final Color bgColor;

  CustomCard({Key key, this.content, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: bgColor,
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: new Offset(2.0, 7.0),
                )
              ],
            ),
            child: content,
          )
        ],
      ),
    );
  }
}
