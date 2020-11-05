import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/selection_button.dart';
import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/providers/exercise_provider.dart';
import 'package:gymapp/screens/select_weight_screen.dart';
import 'package:provider/provider.dart';

class SelectRepetitionsScreen extends StatefulWidget {
  static final String routeName = 'screen/select_repetitions_screen';

  @override
  _SelectRepetitionsScreenState createState() => _SelectRepetitionsScreenState();
}

class _SelectRepetitionsScreenState extends State<SelectRepetitionsScreen> {
  NeumorphicAppBar appBar = NeumorphicAppBar(title: Text('Repetitions'));
  final ScrollController _scrollController = ScrollController();
  List<int> reps = [];

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final exercise = Provider.of<ExerciseProvider>(context, listen: false).currentExercise;
      int index = reps.indexOf(exercise.lastReps);
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

  void setRepetitionList(Exercise exercise) {
    int total = 50;
    int end = (exercise.lastReps + (total / 2)).round();
    int start = end - total;
    for (int i = start; i <= end; i++) {
      reps.add(i);
    }
    reps = reps.where((rep) => rep > 0).toList();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = Provider.of<ExerciseProvider>(context, listen: false).currentExercise;
    setRepetitionList(exercise);

    Function onPressed = (String reps) {
      Navigator.of(context).pushNamed(
        SelectWeightScreen.routeName,
        arguments: SelectWeightScreenArgs(int.parse(reps)),
      );
    };

    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
        controller: _scrollController,
        itemCount: reps.length,
        itemBuilder: (context, index) => SelectionButton(reps[index].toString(), onPressed),
      ),
    );
  }
}
