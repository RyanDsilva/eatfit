import 'package:eatfit/components/customCard.dart';
import 'package:eatfit/models/exercise.dart';
import 'package:eatfit/util/exerciseList.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class DoExercise extends StatefulWidget {
  final String id;
  const DoExercise({Key key, this.id}) : super(key: key);

  @override
  _DoExerciseState createState() => _DoExerciseState();
}

class _DoExerciseState extends State<DoExercise> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  @override
  void dispose() {
    super.dispose();
    advancedPlayer.release();
  }

  Widget _tab(List<Widget> children) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            slider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: children
                  .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn(String txt, IconData icon, VoidCallback onPressed) {
    return RaisedButton.icon(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      icon: Icon(
        icon,
        color: Theme.of(context).accentColor,
      ),
      label: Text(
        txt,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget localAsset(String audioFile) {
    return _tab([
      _btn('Play', Icons.play_arrow, () => audioCache.play(audioFile)),
      _btn('Stop', Icons.stop, () => advancedPlayer.stop()),
    ]);
  }

  Widget slider() {
    return Slider(
        activeColor: Theme.of(context).accentColor,
        inactiveColor: Theme.of(context).primaryColor,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final Exercise exercise = exerciseList[int.parse(this.widget.id)];
    return SingleChildScrollView(
      child: Center(
        child: CustomCard(
          bgColor: Colors.grey.shade100,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  exercise.getName(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              Image.asset(
                exercise.getImage(),
                width: 300,
                height: 300,
              ),
              SizedBox(
                height: 15,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Instructions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              localAsset(exercise.getAudio()),
              Divider(),
              Chip(
                avatar: Icon(
                  Icons.offline_bolt,
                  color: Colors.white,
                ),
                label: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                  child: Text(
                    "Repetitions: " + exercise.getReps(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                elevation: 5,
                labelPadding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                autofocus: true,
                backgroundColor: Theme.of(context).errorColor,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
