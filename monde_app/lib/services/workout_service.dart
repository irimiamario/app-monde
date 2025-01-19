import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/workout.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addWorkout(Workout workout) async {
    try {
      // Set server timestamp for createdAt
      final workoutData = {
        'userId': workout.userId,
        'type': workout.type,
        'duration': workout.duration,
        'date': Timestamp.fromDate(workout.date),
        'calories': workout.calories,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Enable offline persistence for this operation
      await _firestore.enableNetwork();
      
      await _firestore.collection('workouts')
          .add(workoutData)
          .timeout(
            Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException('Failed to save workout. Please check your internet connection.');
            },
          );
          
      print('Workout saved successfully: ${workout.toMap()}');
    } catch (e) {
      print('Error saving workout: $e');
      throw e;
    }
  }

  Stream<List<Workout>> getUserWorkouts(String userId) {
    try {
      return _firestore
          .collection('workouts')
          .where('userId', isEqualTo: userId)
          .orderBy('date', descending: true)
          .snapshots()
          .handleError((error) {
            print('Error getting workouts: $error');
            return [];
          })
          .map((snapshot) => snapshot.docs
              .map((doc) => Workout.fromMap(doc.data(), doc.id))
              .toList());
    } catch (e) {
      print('Error in getUserWorkouts: $e');
      rethrow;
    }
  }
}