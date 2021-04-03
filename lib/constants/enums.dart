// Class to store classified words and types in form of enums.
// Can be real Flutter [enum] or pseudo-enum in form of ordinary class with props getter.
class DailyMood {
  final String moodName;

  const DailyMood._(this.moodName);

  @override
  String toString() => this.moodName;

  static const DailyMood Happy = DailyMood._("Bahagia");
  static const DailyMood Sad = DailyMood._("Sedih");
  static const DailyMood Angry = DailyMood._("Marah");
  static const DailyMood Peaceful = DailyMood._("Damai");
  static const DailyMood Excited = DailyMood._("Riang");
  static const DailyMood Energetic = DailyMood._("Bersemangat");

  static DailyMood getFromString(String moodName) {
    switch (moodName.toLowerCase()) {
      case "bahagia":
        return Happy;
      case "sedih":
        return Sad;
      case "marah":
        return Angry;
      case "damai":
        return Peaceful;
      case "riang":
        return Excited;
      case "bersemangat":
        return Energetic;
      default:
        return null;
    }
  }
}

// TODO: create more enums below
