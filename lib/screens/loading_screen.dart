import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color base = Color(0xff333a42);
    final Color light = Color(0xff4D545C);
    final Color dark = Color(0xff1A2129);
    return NeumorphicApp(
      title: 'Gym App',
      theme: NeumorphicThemeData(
        intensity: 0.8,
        lightSource: LightSource.topLeft,
        baseColor: base,
        shadowLightColor: light,
        shadowDarkColor: dark,
        shadowLightColorEmboss: light,
        shadowDarkColorEmboss: dark,
      ),
      home: Container(
        child: Center(
          child: Text('Loading'),
        ),
      ),
    );
  }
}
