import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/providers/routine.dart';
import 'package:gymapp/providers/workout.dart';

final List<Exercise> dayOne = [
  Exercise(
    id: '1',
    title: 'Dumbell Bench Press',
    sets: 4,
    repetitions: [12, 10, 10, 10],
  ),
  Exercise(
    id: '2',
    title: 'Incline Bench Press',
    sets: 2,
    repetitions: [10, 10],
  ),
  Exercise(
    id: '3',
    title: 'Tricep Dip',
    sets: 3,
  ),
  Exercise(
    id: '4',
    title: 'Lying Tricep Extension',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
];

final List<Exercise> dayTwo = [
  Exercise(
    id: '5',
    title: 'Wide Grip Pull Up',
    sets: 4,
    repetitions: [10, 10, 10, 10],
  ),
  Exercise(
    id: '6',
    title: 'Seated Row',
    sets: 3,
    repetitions: [12, 12, 12],
  ),
  Exercise(
    id: '7',
    title: 'One Arm Dumbbell Row',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
  Exercise(
    id: '8',
    title: 'Standing Barbell Curl',
    sets: 3,
    minReps: 8,
    maxReps: 10,
  ),
];

final List<Exercise> dayThree = [
  Exercise(
    id: '9',
    title: 'Leg press',
    sets: 4,
    repetitions: [12, 10, 10, 10],
  ),
  Exercise(
    id: '10',
    title: 'Leg Extension',
    sets: 3,
    repetitions: [12, 12, 12],
  ),
  Exercise(
    id: '11',
    title: 'Leg Curl',
    sets: 3,
    repetitions: [12, 12, 12],
  ),
  Exercise(
    id: '12',
    title: 'Military Press',
    sets: 4,
    minReps: 8,
    maxReps: 10,
  ),
  Exercise(
    id: '13',
    title: 'Dumbbell Lateral Raise',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
];

final List<Workout> mockWorkouts = [
  Workout(id: '1', title: 'Chest and Triceps', exercises: dayOne),
  Workout(id: '2', title: 'Back and Biceps', exercises: dayTwo),
  Workout(id: '3', title: 'Legs and Shoulders', exercises: dayThree),
];

final List<Routine> mockRoutines = [
  Routine(id: '1', title: 'Three Day Split', workouts: mockWorkouts),
];
