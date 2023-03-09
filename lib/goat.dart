import 'medicine.dart';
import 'feed.dart';

class Goat {
  String? name;
  String tag;
  String? breed;
  DateTime dob;
  double? weight;
  Gender gender;
  String? image;
  String? parent;
  bool isPregnant;
  List<Feed>? feeds;
  List<Feed>? _feeds;

  List<Feed>? getFeeds() => _feeds;
  List<Medicine>? medicines;

  Goat({
    this.name,
    required this.tag,
    this.breed,
    required this.dob,
    this.weight,
    required this.gender,
    this.image,
    this.parent,
    this.isPregnant = false,
    this.feeds,
    this.medicines,
  });
  String get id => tag;

  String get weightUnit {
    if (weight == null) {
      return "Unknown";
    } else if (weight! < 1) {
      return "grams";
    } else if (weight! < 1000) {
      return "kilograms";
    } else {
      return "metric tons";
    }
  }

  factory Goat.fromJson(Map<String, dynamic> json) {
    return Goat(
      name: json['name'],
      tag: json['tag'],
      breed: json['breed'],
      dob: DateTime.parse(json['dob']),
      weight: json['weight'],
      gender: json['gender'] == 'male' ? Gender.male : Gender.female,
      image: json['image'],
      parent: json['parent'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'tag': tag,
        'breed': breed,
        'dob': dob.toIso8601String(),
        'weight': weight,
        'gender': gender == Gender.male ? 'male' : 'female',
        'image': image,
        'parent': parent,
      };
}

enum Gender {
  male,
  female,
}
