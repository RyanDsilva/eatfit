class Exercise {
  String id;
  String _name;
  String _reps;
  String _image;
  String _audio;

  Exercise(this.id, this._name, this._reps, this._audio, this._image);

  String getID() => id;
  String getName() => _name;
  String getReps() => _reps;
  String getImage() => _image;
  String getAudio() => _audio;

  setExercise(String name) => this._name = name;
  setReps(String reps) => this._reps = reps;
  setImage(String image) => this._image = image;
  setAudio(String audio) => this._audio = audio;
}
