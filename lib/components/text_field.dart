import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final EdgeInsets margin;
  final TextInputType keyboardType;
  final bool autoFocus;
  final TextInputAction textInputAction;
  final Function() onEditingComplete;

  NeumorphicTextField({
    @required this.controller,
    this.placeholder,
    this.margin,
    this.keyboardType,
    this.autoFocus = false,
    this.textInputAction,
    this.onEditingComplete,
  });

  @override
  _NeumorphicTextFieldState createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      width: double.infinity,
      child: Neumorphic(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: TextField(
          textInputAction: widget.textInputAction,
          onEditingComplete: widget.onEditingComplete,
          autofocus: widget.autoFocus,
          keyboardType: widget.keyboardType,
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
