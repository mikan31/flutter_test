import 'package:flutter/material.dart';
import 'root.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //デバッグを表示しない
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blueGrey[900],
      ),
      home: RootWidget(),
    );
  }
}
