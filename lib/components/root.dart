import 'package:eatfit/components/bottomAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  final Widget child;

  const Root({Key key, this.child}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    var _items = [
      {'icon': Icon(Icons.photo_camera), 'text': Text("Camera")},
      {'icon': Icon(Icons.photo), 'text': Text("Gallery")}
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EatFit",
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: this.widget.child,
      floatingActionButton: FloatingActionButton(
        focusColor: Color(0xFF7C7C7C),
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black26,
                ),
                itemCount: 2,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    title: _items[index]['text'],
                    leading: _items[index]['icon'],
                    onTap: () => Navigator.pushNamed(context, "snap/$index"),
                  ),
                ),
              );
            }),
        tooltip: 'Action',
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
        elevation: 3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        notchedShape: CircularNotchedRectangle(),
        color: Theme.of(context).accentColor,
        selectedColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).primaryColor,
        centerItemText: "Snap!",
        iconSize: 30,
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          FABBottomAppBarItem(iconData: Icons.local_dining, text: 'Food'),
          FABBottomAppBarItem(iconData: Icons.fitness_center, text: 'Exercise'),
          FABBottomAppBarItem(iconData: Icons.settings, text: 'Settings'),
        ],
      ),
    );
  }

  void _selectedTab(int index) {
    print("Tab: $index");
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, 'home');
        break;
      case 1:
        Navigator.pushNamed(context, 'food');
        break;
      case 2:
        Navigator.pushNamed(context, 'exercise');
        break;
      case 3:
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, 'home');
        break;
      default:
        print(index);
    }
  }
}
