import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/selection_button.dart';
import 'package:gymapp/database/exercise_history_db.dart';
import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/modules/exercise_history.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/user_provider.dart';
import 'package:gymapp/screens/rest_screen.dart';
import 'package:gymapp/util/helpers.dart';
import 'package:provider/provider.dart';

class SelectWeightScreenArgs {
  Exercise exercise;
  int reps;

  SelectWeightScreenArgs(this.exercise, this.reps);
}

class SelectWeightScreen extends StatefulWidget {
  static final String routeName = 'screen/select_weights_screen';

  const SelectWeightScreen();

  @override
  _SelectWeightScreenState createState() => _SelectWeightScreenState();
}

class _SelectWeightScreenState extends State<SelectWeightScreen> {
  NeumorphicAppBar appBar = NeumorphicAppBar(title: Text('Weight'));
  final ScrollController _scrollController = ScrollController();
  List<double> weights = [];

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final args = ModalRoute.of(context).settings.arguments as SelectWeightScreenArgs;
      int index = weights.indexOf(args.exercise.lastWeight);
      if (index == -1) {
        return;
      }
      double height = MediaQuery.of(context).size.height;
      int buttonSize = 140;
      int buttonMargin = 8;
      double distance =
          index * (buttonSize + (buttonMargin * 2)) - (height / 2) + (buttonSize / 2) + appBar.preferredSize.height;
      _scrollController.jumpTo(distance);
    });
  }

  void setWeights(Exercise exercise) {
    int total = 50;
    double end = exercise.lastWeight + (total / 2);
    double start = end - total;
    for (double i = start; i <= end; i += 0.5) {
      weights.add(i);
    }
    weights = weights.where((weight) => weight > 0).toList();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as SelectWeightScreenArgs;
    setWeights(args.exercise);

    Function onPressed = (String weight) {
      args.exercise.completeSet(args.reps, double.parse(weight));
      final userId = Provider.of<UserProvider>(context, listen: false).user.id;
      var newExerciseHistory = ExerciseHistory(args.exercise.id, args.reps, double.parse(weight));
      createExerciseHistory(userId, newExerciseHistory);
      Provider.of<RoutineProvider>(context, listen: false).saveData();
      Navigator.of(context).pushNamed(RestScreen.routeName, arguments: args.exercise);
    };

    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
        controller: _scrollController,
        itemCount: weights.length,
        itemBuilder: (context, index) => SelectionButton(removeDecimalZeroFormat(weights[index]), onPressed),
      ),
    );
  }
}
