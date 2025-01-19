import 'package:flutter/material.dart';
import '../../models/tutorial.dart';
import '../../services/tutorial_service.dart';

class WorkoutTutorials extends StatefulWidget {
  const WorkoutTutorials({Key? key}) : super(key: key);
  
  @override
  State<WorkoutTutorials> createState() => _WorkoutTutorialsState();
}

class _WorkoutTutorialsState extends State<WorkoutTutorials> {
  final TutorialService _tutorialService = TutorialService();
  String _selectedCategory = 'All';
  bool _isLoading = true;

  final List<String> _categories = [
    'All',
    'Strength',
    'Cardio',
    'Flexibility',
    'HIIT',
    'Yoga',
  ];

  @override
  void initState() {
    super.initState();
    _addSampleTutorials();
  }

  Future<void> _addSampleTutorials() async {
    try {
      setState(() => _isLoading = true);
      await _tutorialService.addSampleTutorials();
      print('Sample tutorials added successfully');
    } catch (e) {
      print('Error adding sample tutorials: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Tutorials'),
      ),
      body: _isLoading 
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: FilterChip(
                          label: Text(category),
                          selected: _selectedCategory == category,
                          onSelected: (selected) {
                            setState(() => _selectedCategory = category);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Tutorial>>(
                    stream: _selectedCategory == 'All'
                        ? _tutorialService.getTutorials()
                        : _tutorialService.getTutorialsByCategory(_selectedCategory),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final tutorials = snapshot.data ?? [];

                      if (tutorials.isEmpty) {
                        return Center(
                          child: Text('No tutorials available'),
                        );
                      }

                      return ListView.builder(
                        itemCount: tutorials.length,
                        itemBuilder: (context, index) {
                          final tutorial = tutorials[index];
                          return Card(
                            margin: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.network(
                                    tutorial.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: Icon(
                                          Icons.error_outline,
                                          size: 40,
                                          color: Colors.grey[600],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tutorial.title,
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        tutorial.description,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          Chip(
                                            label: Text(tutorial.difficulty),
                                            backgroundColor: _getDifficultyColor(
                                              tutorial.difficulty,
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Text(
                                            '${tutorial.duration} min',
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green[100]!;
      case 'intermediate':
        return Colors.orange[100]!;
      case 'advanced':
        return Colors.red[100]!;
      default:
        return Colors.grey[100]!;
    }
  }
}