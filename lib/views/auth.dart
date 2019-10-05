import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eatfit/util/bottomWaveClipper.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  String _email;
  String _password;
  String _displayName;
  bool isLoading = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Firestore db = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;

    Widget logo() {
      return Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  child: Align(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      width: 175,
                      height: 175,
                    ),
                  ),
                  height: 154,
                ),
              ),
              Positioned(
                child: Container(
                  height: 154,
                  child: Align(
                    child: Text(
                      "EatFit",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.15,
                bottom: MediaQuery.of(context).size.height * 0.046,
                right: MediaQuery.of(context).size.width * 0.22,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
                bottom: 0,
                right: MediaQuery.of(context).size.width * 0.32,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    //input widget
    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
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

    //button widget
    Widget _button(String text, Color splashColor, Color highlightColor,
        Color fillColor, Color textColor, void function()) {
      return RaisedButton(
        highlightElevation: 0.0,
        splashColor: splashColor,
        highlightColor: highlightColor,
        elevation: 0.0,
        color: fillColor,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          function();
        },
      );
    }

    void _loginUser() async {
      showInSnackBar('Logging You In ...');
      _email = _emailController.text;
      _password = _passwordController.text;
      _emailController.clear();
      _passwordController.clear();
      final FirebaseUser user = (await firebaseAuth.signInWithEmailAndPassword(
              email: _email, password: _password))
          .user;
      Navigator.pushReplacementNamed(context, "dashboard/${user.uid}");
    }

    void _registerUser() async {
      showInSnackBar('Signing You Up ...');
      _email = _emailController.text;
      _password = _passwordController.text;
      _displayName = _nameController.text;
      _emailController.clear();
      _passwordController.clear();
      _nameController.clear();
      final FirebaseUser _user =
          (await firebaseAuth.createUserWithEmailAndPassword(
                  email: _email, password: _password))
              .user;
      DocumentReference ref = db.collection("users").document(_user.uid);
      ref.setData({
        'id': _user.uid,
        'email': _user.email,
        'name': _displayName,
        'gender': 'Male',
      }, merge: true);
      Navigator.pushReplacementNamed(context, "dashboard/${_user.uid}");
    }

    void _loginSheet() {
      _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Colors.transparent),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
            child: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _emailController.clear();
                              _passwordController.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    height: 50,
                    width: 50,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                child: Align(
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20, top: 60),
                          child: _input(
                            Icon(Icons.email),
                            "EMAIL",
                            _emailController,
                            false,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: _input(
                            Icon(Icons.lock),
                            "PASSWORD",
                            _passwordController,
                            true,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Container(
                            child: _button(
                              "LOGIN",
                              Colors.white,
                              primary,
                              primary,
                              Colors.white,
                              _loginUser,
                            ),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ),
        );
      });
    }

    void _registerSheet() {
      _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Colors.transparent),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
            child: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _emailController.clear();
                              _passwordController.clear();
                              _nameController.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    height: 50,
                    width: 50,
                  ),
                  SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: Align(
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Positioned(
                              child: Container(
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                          top: 60,
                        ),
                        child: _input(
                          Icon(Icons.account_circle),
                          "NAME",
                          _nameController,
                          false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: _input(
                          Icon(Icons.email),
                          "EMAIL",
                          _emailController,
                          false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: _input(
                          Icon(Icons.lock),
                          "PASSWORD",
                          _passwordController,
                          true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Container(
                          child: _button(
                            "REGISTER",
                            Colors.white,
                            primary,
                            primary,
                            Colors.white,
                            _registerUser,
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ),
        );
      });
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          logo(),
          Padding(
            child: Container(
              child: _button(
                "LOGIN",
                primary,
                Colors.white,
                Colors.white,
                primary,
                _loginSheet,
              ),
              height: 50,
            ),
            padding: EdgeInsets.only(
              top: 80,
              left: 20,
              right: 20,
            ),
          ),
          Padding(
            child: Container(
              child: OutlineButton(
                highlightedBorderColor: Colors.white,
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                highlightElevation: 0.0,
                splashColor: Colors.white,
                highlightColor: Theme.of(context).primaryColor,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  _registerSheet();
                },
              ),
              height: 50,
            ),
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          ),
          Expanded(
            child: Align(
              child: ClipPath(
                child: Container(
                  color: Colors.white,
                  height: 300,
                ),
                clipper: BottomWaveClipper(),
              ),
              alignment: Alignment.bottomCenter,
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
