import 'dart:async';
import 'dart:io';
import 'package:eatfit/components/customLoader.dart';
import 'package:eatfit/models/user.dart';
import 'package:eatfit/util/api.dart';
import 'package:eatfit/util/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  API server = API();
  DatabaseService db = DatabaseService();
  bool isLoading = false;
  String prediction = '';
  User user;
  TextEditingController _calorieController = new TextEditingController();
  String calories;

  @override
  initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      db.getUser(user.uid).then((currUser) {
        setState(() {
          this.user = currUser;
        });
      });
    });
    getImage(this.widget.value);
  }

  void predict() async {
    setState(() {
      this.isLoading = true;
    });
    String res = await server.predictFood(this._image);
    setState(() {
      this.prediction = res;
      this.isLoading = false;
    });
  }

  void updateMeal() {
    calories = _calorieController.text;
    _calorieController.clear();
    Map m = {
      "name": this.prediction,
      "calories": int.parse(calories),
      "time": DateTime.now()
    };
    List l = [m];
    db.addMeal(l, this.user.id);
    Navigator.popAndPushNamed(context, 'food');
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

  Widget _input(
      Icon icon, String hint, TextEditingController controller, bool obsecure) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          prefixIcon: Padding(
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).accentColor),
              child: icon,
            ),
            padding: EdgeInsets.only(left: 30, right: 10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new CustomCard(
        bgColor: Colors.grey.shade100,
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
                child: RaisedButton(
                  onPressed: () => this.predict(),
                  child: Text(
                    "Predict",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                padding: EdgeInsets.all(5),
              ),
              Padding(
                child: this.isLoading
                    ? CustomLoader()
                    : Text(
                        this.prediction,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                padding: EdgeInsets.all(5),
              ),
              _input(Icon(Icons.fastfood), "Calories", this._calorieController,
                  false),
              Padding(
                child: RaisedButton(
                  onPressed: () => this.updateMeal(),
                  child: Text(
                    "Add To Log",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                padding: EdgeInsets.all(5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
