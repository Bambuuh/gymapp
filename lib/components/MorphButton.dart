import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MorphButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final EdgeInsets margin;

  MorphButton({@required this.child, @required this.onPressed, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NeumorphicButton(
        style: NeumorphicStyle(boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(100))),
        margin: margin,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
