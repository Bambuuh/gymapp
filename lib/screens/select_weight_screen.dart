import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/selection_button.dart';
import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/screens/rest_screen.dart';
import 'package:gymapp/util/helpers.dart';

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
      final exercise = ModalRoute.of(context).settings.arguments as Exercise;
      int index = weights.indexOf(exercise.lastWeight);
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
    final exercise = ModalRoute.of(context).settings.arguments as Exercise;
    setWeights(exercise);

    Function onPressed = (String weights) {
      exercise.lastWeight = double.parse(weights);
      exercise.completeSet();
      Navigator.of(context).pushNamed(RestScreen.routeName, arguments: exercise);
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
