import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eatfit/components/customCard.dart';

class Snap extends StatefulWidget {
  final int value;

  const Snap({Key key, this.value}) : super(key: key);

  @override
  _SnapState createState() => _SnapState();
}

class _SnapState extends State<Snap> {
  File _image;

  @override
  initState() {
    super.initState();
    getImage(this.widget.value);
  }

  Future getImage(int value) async {
    switch (value) {
      case 0:
        var image = await ImagePicker.pickImage(source: ImageSource.camera);
        setState(() {
          _image = image;
        });
        break;
      case 1:
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          _image = image;
        });
        break;
      default:
        print("Wrong Choice");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new CustomCard(
        bgColor: Colors.black12,
        content: new Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: _image == null
                    ? Text(
                        'No image selected!\nPlease snap your food again!',
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Image.file(_image),
              ),
              Padding(
                child: Text("food_name"),
                padding: EdgeInsets.all(10),
              ),
              Padding(
                child: RaisedButton(
                  onPressed: () => print("Clicked!"),
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                padding: EdgeInsets.all(5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
