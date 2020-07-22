import 'package:flutter/cupertino.dart';
import 'package:bandnamessurvey_app/src/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: CupertinoPageScaffold(
        child: Center(
          child: Container(
            child: HomeScreen(),
          ),
        ),
      ),
    );
  }
}