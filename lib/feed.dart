class Feed {
  final String name;

  Feed({required this.name});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
