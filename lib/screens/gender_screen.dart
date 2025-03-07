import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String name = '';
  String gender = '';
  Color backgroundColor = Colors.white;

  Future<void> predictGender() async {
    final response = await http.get(
      Uri.parse('https://api.genderize.io/?name=$name'),
    );
    final data = json.decode(response.body);

    setState(() {
      gender = data['gender'];
      backgroundColor = gender == 'male' ? Colors.blue : Colors.pink;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Predecir Género')),
      body: Container(
        color: backgroundColor,
        child: Padding(
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
                onPressed: predictGender,
                child: Text('Predecir Género'),
              ),
              SizedBox(height: 20),
              Text('Género: $gender'),
            ],
          ),
        ),
      ),
    );
  }
}
