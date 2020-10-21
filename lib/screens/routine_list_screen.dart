import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/routine_item.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/screens/add_routine_screen.dart';
import 'package:provider/provider.dart';

class RoutineListScreen extends StatefulWidget {
  static final String routeName = 'screen/routine_list_screen';

  @override
  _RoutineListScreenState createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends State<RoutineListScreen> {
  @override
  Widget build(BuildContext context) {
    var routineProvider = Provider.of<RoutineProvider>(context);
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Column(
          children: routineProvider.routines
              .map((routine) => RoutineItem(routine))
              .toList(),
        ),
      ),
      floatingActionButton: NeumorphicButton(
        style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
        onPressed: () {
          Navigator.of(context).pushNamed(AddRoutineScreen.routeName);
        },
        tooltip: 'Add workout',
        child: Icon(Icons.add),
      ),
    );
  }
}
