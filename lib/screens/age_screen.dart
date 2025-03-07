import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  String name = '';
  int age = 0;
  String ageGroup = '';
  String imagePath = '';

  Future<void> determineAge() async {
    final response = await http.get(
      Uri.parse('https://api.agify.io/?name=$name'),
    );
    final data = json.decode(response.body);

    setState(() {
      age = data['age'];
      if (age < 30) {
        ageGroup = 'Joven';
        imagePath = 'assets/images/young.png';
      } else if (age >= 30 && age < 60) {
        ageGroup = 'Adulto';
        imagePath = 'assets/images/adult.png';
      } else {
        ageGroup = 'Anciano';
        imagePath = 'assets/images/old.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Determinar Edad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Ingresa un nombre'),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: determineAge,
              child: Text('Determinar Edad'),
            ),
            SizedBox(height: 20),
            Text('Edad: $age'),
            Text('Grupo de edad: $ageGroup'),
            if (imagePath.isNotEmpty) Image.asset(imagePath),
          ],
        ),
      ),
    );
  }
}
