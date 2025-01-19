class UserProfile {
  final String id;
  final String name;
  final String email;
  final int age;
  final double weight;
  final double height;
  final String fitnessGoal;
  final String profileImageUrl;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.weight,
    required this.height,
    required this.fitnessGoal,
    required this.profileImageUrl,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map, String id) {
    return UserProfile(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? 0,
      weight: (map['weight'] ?? 0).toDouble(),
      height: (map['height'] ?? 0).toDouble(),
      fitnessGoal: map['fitnessGoal'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'weight': weight,
      'height': height,
      'fitnessGoal': fitnessGoal,
      'profileImageUrl': profileImageUrl,
    };
  }
}