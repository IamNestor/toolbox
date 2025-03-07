import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UniversitiesScreen extends StatefulWidget {
  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  String country = '';
  List<dynamic> universities = [];

  Future<void> fetchUniversities() async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    final data = json.decode(response.body);

    setState(() {
      universities = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Ingresa un país en inglés'),
              onChanged: (value) {
                setState(() {
                  country = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchUniversities,
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  final university = universities[index];
                  return ListTile(
                    title: Text(university['name']),
                    subtitle: Text('Dominio: ${university['domains'][0]}'),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () {
                        final url = university['web_pages'][0];
                        // Abrir en el navegador
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}