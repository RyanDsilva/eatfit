import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:eatfit/components/customCard.dart';

class Snap extends StatefulWidget {
  @override
  _SnapState createState() => _SnapState();
}

class _SnapState extends State<Snap> {
  File _image;

  @override
  initState() {
    super.initState();
    getImage();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        new CustomCard(
          bgColor: Colors.black12,
          content: new Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image),
                ),
                Padding(
                  child: Text("food_name"),
                  padding: EdgeInsets.all(10),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
