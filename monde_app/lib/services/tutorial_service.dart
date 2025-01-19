import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tutorial.dart';

class TutorialService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSampleTutorials() async {
    final tutorials = [
      {
        'title': 'Perfect Push-Up Form',
        'description': 'Master the perfect push-up technique for maximum chest and triceps development.',
        'category': 'Strength',
        'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/monde-app-58f25.firebasestorage.app/o/stock.jpg?alt=media&token=986eb7fd-ca9a-4dc8-ac6f-ce425bb94f9c',  // Replace with actual image URL
        'videoUrl': 'https://www.youtube.com/watch?v=IODxDxX7oi4&list=PPSV',
        'duration': 15,
        'difficulty': 'Beginner'
      },
      {
        'title': 'HIIT Cardio Workout',
        'description': 'High-intensity interval training for maximum calorie burn and cardiovascular fitness.',
        'category': 'HIIT',
        'imageUrl': 'https://media.istockphoto.com/id/1305549557/ro/fotografie/fit-femeie-hispanic-%C3%AEn-activewear-exercitarea-la-sala-de-sport.jpg?s=612x612&w=0&k=20&c=Eaw0TGYQyqii6VD2hoadB7Kuvv1KLTmgok_RQFJyer4=',
        'videoUrl': 'https://example.com/hiit-video',
        'duration': 30,
        'difficulty': 'Intermediate'
      },
      {
        'title': 'Full Body Flexibility Routine',
        'description': 'Improve your overall flexibility and mobility with this comprehensive routine.',
        'category': 'Flexibility',
        'imageUrl': 'https://example.com/flexibility.jpg',
        'videoUrl': 'https://example.com/flexibility-video',
        'duration': 20,
        'difficulty': 'Beginner'
      }
    ];

    for (var tutorial in tutorials) {
      await _firestore.collection('tutorials').add(tutorial);
    }
  }
  Stream<List<Tutorial>> getTutorials() {
    try {
      return _firestore
          .collection('tutorials')
          .orderBy('title')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Tutorial.fromMap(doc.data(), doc.id))
              .toList());
    } catch (e) {
      print('Error getting tutorials: $e');
      return Stream.value([]);
    }
  }

  Stream<List<Tutorial>> getTutorialsByCategory(String category) {
    try {
      return _firestore
          .collection('tutorials')
          .where('category', isEqualTo: category)
          .orderBy('title')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Tutorial.fromMap(doc.data(), doc.id))
              .toList());
    } catch (e) {
      print('Error getting tutorials by category: $e');
      return Stream.value([]);
    }
  }
}
