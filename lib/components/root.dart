import 'package:eatfit/components/bottomAppBar.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Eat-Fit"),
        centerTitle: true,
      ),
      body: this.widget.child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(context, 'snap'),
        tooltip: 'Action',
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
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
        Navigator.pushReplacementNamed(context, 'food');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, 'exercise');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, 'settings');
        break;
      default:
        print(index);
    }
  }
}
