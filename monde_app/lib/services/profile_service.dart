import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserProfile.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting user profile: $e');
      rethrow;
    }
  }

  Future<void> updateUserProfile(String userId, UserProfile profile) async {
    try {
      print('Attempting to save profile for user: $userId');
      print('Profile data: ${profile.toMap()}');
      
      await _firestore.collection('users').doc(userId).set(
        profile.toMap(),
        SetOptions(merge: true),
      );
      
      print('Profile saved successfully');
    } catch (e) {
      print('Error saving profile: $e');
      rethrow;
    }
  }
}