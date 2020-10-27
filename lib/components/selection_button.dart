import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SelectionButton extends StatelessWidget {
  final String value;
  final Function onPresssed;

  const SelectionButton(this.value, this.onPresssed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 140,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: NeumorphicButton(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              value,
              style: TextStyle(fontSize: 40),
            ),
          ),
          onPressed: () => onPresssed(value),
        ),
      ),
    );
  }
}
