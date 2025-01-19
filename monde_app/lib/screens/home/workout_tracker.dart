import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../services/workout_service.dart';
import '../../models/workout.dart';

class WorkoutTracker extends StatefulWidget {
  const WorkoutTracker({Key? key}) : super(key: key);
  
  @override
  State<WorkoutTracker> createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
  final WorkoutService _workoutService = WorkoutService();
  final _formKey = GlobalKey<FormState>();
  
  String _selectedType = 'Running';
  int _duration = 30;
  int _calories = 300;

  final List<String> _workoutTypes = [
    'Running',
    'Cycling',
    'Swimming',
    'Weight Training',
    'Yoga',
    'HIIT',
  ];

  Future<void> _addWorkout() async {
    if (_formKey.currentState!.validate()) {
      final user = Provider.of<AuthService>(context, listen: false).user;
      
      if (user != null) {
        try {
          print('Creating workout with userId: ${user.uid}');
          final workout = Workout(
            id: '',  // Firestore will generate this
            userId: user.uid,
            type: _selectedType,
            duration: _duration,
            date: DateTime.now(),
            calories: _calories,
          );

          print('Attempting to save workout: ${workout.toMap()}');
          await _workoutService.addWorkout(workout);
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Workout added successfully!')),
            );
          }
        } catch (e) {
          print('Error saving workout: $e');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error saving workout: $e')),
            );
          }
        }
      } else {
        print('No user found');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Tracker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    decoration: InputDecoration(
                      labelText: 'Workout Type',
                      border: OutlineInputBorder(),
                    ),
                    items: _workoutTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedType = value);
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: _duration.toString(),
                    decoration: InputDecoration(
                      labelText: 'Duration (minutes)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter duration';
                      }
                      final duration = int.tryParse(value);
                      if (duration == null || duration <= 0) {
                        return 'Please enter a valid duration';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final duration = int.tryParse(value);
                      if (duration != null) {
                        setState(() => _duration = duration);
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: _calories.toString(),
                    decoration: InputDecoration(
                      labelText: 'Calories Burned',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter calories';
                      }
                      final calories = int.tryParse(value);
                      if (calories == null || calories <= 0) {
                        return 'Please enter valid calories';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final calories = int.tryParse(value);
                      if (calories != null) {
                        setState(() => _calories = calories);
                      }
                    },
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: _addWorkout,
                    child: Text('Add Workout'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            Expanded(
              child: StreamBuilder<List<Workout>>(
                stream: user != null
                    ? _workoutService.getUserWorkouts(user.uid)
                    : Stream.value([]),
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

                  final workouts = snapshot.data ?? [];

                  if (workouts.isEmpty) {
                    return Center(
                      child: Text('No workouts yet. Add your first one!'),
                    );
                  }

                  return ListView.builder(
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      final workout = workouts[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: Icon(_getWorkoutIcon(workout.type)),
                          title: Text(workout.type),
                          subtitle: Text(
                            '${workout.duration} minutes • ${workout.calories} calories',
                          ),
                          trailing: Text(
                            _formatDate(workout.date),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWorkoutIcon(String type) {
    switch (type.toLowerCase()) {
      case 'running':
        return Icons.directions_run;
      case 'cycling':
        return Icons.directions_bike;
      case 'swimming':
        return Icons.pool;
      case 'weight training':
        return Icons.fitness_center;
      case 'yoga':
        return Icons.self_improvement;
      case 'hiit':
        return Icons.timer;
      default:
        return Icons.sports;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}