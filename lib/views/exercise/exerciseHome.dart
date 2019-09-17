import 'package:flutter/material.dart';

class Exercise extends StatelessWidget {
  const Exercise({Key key}) : super(key: key);

  Widget cards(image, title, reps, audio) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6.0,
          ),
        ],
        color: Colors.grey.shade100,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              image,
              height: 80,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 4),
              color: Color(0xFF92DCE5),
              child: Text(
                "x " + reps,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Theme.of(context).primaryColor,
            ),
            width: double.infinity,
          ),
          Container(
            margin: EdgeInsets.only(left: 90, bottom: 20),
            width: 299,
            height: 279,
            decoration: BoxDecoration(
              color: Colors.blueAccent.shade200,
              // color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(160),
                bottomLeft: Radius.circular(290),
                bottomRight: Radius.circular(160),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Today's Exercise",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Routine",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(26.0),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: <Widget>[
                    cards('assets/gifs/SDM_9.gif', 'Leg Stretch', '30', ''),
                    cards('assets/gifs/SDM_12.gif', 'Side-to-Side', '25', ''),
                    cards('assets/gifs/SDM_18.gif', 'Vert. Crunch', '20', ''),
                    cards('assets/gifs/SDM_23.gif', 'Spot Jog', '50', ''),
                    cards('assets/gifs/SDM_58.gif', 'Elbow-Knee', '25', ''),
                    cards('assets/gifs/SDM_65.gif', 'Back Push', '20', ''),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
