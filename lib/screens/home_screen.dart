import 'package:flutter/material.dart';
//import 'gender_screen.dart';
//import 'age_screen.dart';
//import 'about_screen.dart';
import '../widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Toolbox App')),
      drawer: DrawerWidget(),
      body: Center(child: Image.asset('assets/images/toolbox.png')),
    );
  }
}
