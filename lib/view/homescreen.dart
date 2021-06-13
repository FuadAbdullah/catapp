import 'package:flutter/material.dart';
import 'package:catapp/view/catphotoui.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cute Kittens',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: CatGrid(),
    );
  }
}
