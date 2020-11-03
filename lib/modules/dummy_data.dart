import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/providers/routine.dart';
import 'package:gymapp/providers/workout.dart';

final List<Exercise> chestAndTricep = [
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

final List<Exercise> backAndBicep = [
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

final List<Exercise> legAndShoulder = [
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

final List<Exercise> workoutA = [
  Exercise(
    id: '14',
    title: 'Incline Barbell Bench Press',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
  Exercise(
    id: '15',
    title: 'Flat Barbell Bench Press',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
  Exercise(
    id: '16',
    title: 'Dip',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
  Exercise(
    id: '17',
    title: 'Barbell Pullover',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
];

final List<Exercise> workoutB = [
  Exercise(
    id: '18',
    title: 'Barbell Squat',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
  Exercise(
    id: '19',
    title: 'Front Barbell Squat',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
  Exercise(
    id: '20',
    title: 'Sumo Deadlift',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
  Exercise(
    id: '21',
    title: 'Barbell Stiff-Legged Deadlift',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
];
final List<Exercise> workoutC = [
  Exercise(
    id: '22',
    title: 'Barbell Military Press',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
  Exercise(
    id: '23',
    title: 'Barbell Upright Row',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
  Exercise(
    id: '24',
    title: 'Barbell Clean and Press',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
];

final List<Exercise> workoutD = [
  Exercise(
    id: '25',
    title: 'Pull-up',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
  Exercise(
    id: '26',
    title: 'Bent-Over Barbell Row',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
  Exercise(
    id: '27',
    title: 'Barbell Deadlift',
    sets: 4,
    repetitions: [15, 8, 8, 6],
  ),
];

final List<Exercise> dayOne = [
  Exercise(
    id: '28',
    title: 'Back Squats',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '29',
    title: 'Bent Over Rows',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '30',
    title: 'Flat Barbell Press',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '31',
    title: 'Push Press',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '32',
    title: 'Skull Crushers',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
  Exercise(
    id: '33',
    title: 'Lateral Raise',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
  Exercise(
    id: '34',
    title: 'Seated Calf Raise',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
];

final List<Exercise> dayTwo = [
  Exercise(
    id: '35',
    title: 'Deadlifts',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '36',
    title: 'Pull-Ups',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '37',
    title: 'Incline Press',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '38',
    title: 'Overhead Press',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '39',
    title: 'Barbell Curls',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
  Exercise(
    id: '40',
    title: 'Bent Over Reverse Flys',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
  Exercise(
    id: '41',
    title: 'Standing Calf Raises',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
];

final List<Exercise> dayThree = [
  Exercise(
    id: '42',
    title: 'Front Squats',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '43',
    title: 'V Grip Bent Over Rows',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '44',
    title: 'Chest Dips',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '45',
    title: 'Single Arm Dumbell Shoulder Press',
    sets: 5,
    repetitions: [5, 5, 5, 5, 5],
  ),
  Exercise(
    id: '46',
    title: 'Single Arm Dumbell Triceps Extension',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
  Exercise(
    id: '47',
    title: 'Cable Front Raises',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
  Exercise(
    id: '48',
    title: 'Seated Calf Raises',
    sets: 3,
    repetitions: [10, 10, 10],
  ),
];

final List<Workout> threeDaySplit = [
  Workout(id: '1', title: 'Chest and Triceps', exercises: chestAndTricep),
  Workout(id: '2', title: 'Back and Biceps', exercises: backAndBicep),
  Workout(id: '3', title: 'Legs and Shoulders', exercises: legAndShoulder),
];

final List<Workout> rc26 = [
  Workout(id: '4', title: 'Workout A', exercises: workoutA),
  Workout(id: '5', title: 'Workout B', exercises: workoutB),
  Workout(id: '6', title: 'Workout C', exercises: workoutC),
  Workout(id: '7', title: 'Workout D', exercises: workoutD),
];

final List<Workout> buffDudesWorkout = [
  Workout(id: '1', title: 'Day One', exercises: dayOne),
  Workout(id: '2', title: 'Day Two', exercises: dayTwo),
  Workout(id: '3', title: 'Day Three', exercises: dayThree),
];

final List<Workout> mockWorkouts = [...threeDaySplit, ...rc26];

final List<Routine> mockRoutines = [
  Routine(id: '1', title: 'Three Day Split', workouts: threeDaySplit),
  Routine(id: '2', title: 'RC26', workouts: rc26),
  Routine(id: '3', title: 'Buff Dudes Workout', workouts: buffDudesWorkout),
];
