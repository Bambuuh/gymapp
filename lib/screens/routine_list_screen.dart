import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/routine_list.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/screens/add_routine_screen.dart';
import 'package:gymapp/screens/routine_screen.dart';
import 'package:provider/provider.dart';

class RoutineListScreen extends StatefulWidget {
  static final String routeName = 'screen/routine_list_screen';

  @override
  _RoutineListScreenState createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends State<RoutineListScreen> {
  void onBack(_) {
    setState(() {});
  }

  void onPressItem(context, String id) {
    final routine = Provider.of<RoutineProvider>(context, listen: false).findById(id);
    Navigator.pushNamed(context, RoutineScreen.routeName, arguments: RoutineScreenArgs(routine));
  }

  @override
  Widget build(BuildContext context) {
    var routines = Provider.of<RoutineProvider>(context).routines;
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text('Routines'),
      ),
      body: Container(child: RoutineList(routines, onPressItem)),
      floatingActionButton: NeumorphicButton(
        style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
        onPressed: () {
          Navigator.of(context).pushNamed(AddRoutineScreen.routeName).then(onBack);
        },
        tooltip: 'Add workout',
        child: Icon(Icons.add),
      ),
    );
  }
}
