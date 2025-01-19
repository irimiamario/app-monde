class Tutorial {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String videoUrl;
  final int duration;
  final String difficulty;

  Tutorial({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.videoUrl,
    required this.duration,
    required this.difficulty,
  });

  factory Tutorial.fromMap(Map<String, dynamic> map, String id) {
    return Tutorial(
      id: id,
      title: map['title'],
      description: map['description'],
      category: map['category'],
      imageUrl: map['imageUrl'],
      videoUrl: map['videoUrl'],
      duration: map['duration'],
      difficulty: map['difficulty'],
    );
  }
  
}