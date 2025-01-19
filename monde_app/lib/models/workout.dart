import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String id;
  final String userId;
  final String type;
  final int duration;
  final DateTime date;
  final int calories;

  Workout({
    required this.id,
    required this.userId,
    required this.type,
    required this.duration,
    required this.date,
    required this.calories,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type,
      'duration': duration,
      'date': Timestamp.fromDate(date),  // Convert DateTime to Timestamp
      'calories': calories,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map, String id) {
    return Workout(
      id: id,
      userId: map['userId'] ?? '',
      type: map['type'] ?? '',
      duration: map['duration'] ?? 0,
      date: (map['date'] as Timestamp).toDate(),  // Convert Timestamp to DateTime
      calories: map['calories'] ?? 0,
    );
  }
}