import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/MorphButton.dart';
import 'package:gymapp/components/text_field.dart';
import 'package:gymapp/database/routines_db.dart';
import 'package:gymapp/providers/routine.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/user_provider.dart';
import 'package:gymapp/screens/routine_screen.dart';
import 'package:provider/provider.dart';

class AddRoutineScreen extends StatefulWidget {
  static final String routeName = 'screen/add_routine_screen';

  @override
  _AddRoutineScreenState createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  final titleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  void onPressSave(context) {
    final newRoutine = Routine(title: titleController.text.toString());
    Provider.of<RoutineProvider>(context, listen: false).addRoutine(newRoutine);
    final userId = Provider.of<UserProvider>(context, listen: false).user.id;
    addRoutine(userId, newRoutine);
    Navigator.of(context).pushReplacementNamed(
      RoutineScreen.routeName,
      arguments: newRoutine.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: NeumorphicAppBar(title: Text('Add Routine')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              NeumorphicTextField(
                controller: titleController,
                placeholder: 'Title',
                autoFocus: true,
              ),
              MorphButton(
                child: Text('Create Routine'),
                onPressed: () => onPressSave(context),
                margin: EdgeInsets.only(top: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
