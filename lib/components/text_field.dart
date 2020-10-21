import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;

  NeumorphicTextField(this.controller, this.placeholder);

  @override
  _NeumorphicTextFieldState createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Neumorphic(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
        style: NeumorphicStyle(
          depth: -4,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(99)),
        ),
      ),
    );
  }
}
