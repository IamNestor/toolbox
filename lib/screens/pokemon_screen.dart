import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonScreen extends StatefulWidget {
  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  String pokemonName = '';
  Map<String, dynamic> pokemonData = {};

  Future<void> fetchPokemon() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));
    final data = json.decode(response.body);

    setState(() {
      pokemonData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Ingresa el nombre de un Pokémon'),
              onChanged: (value) {
                setState(() {
                  pokemonName = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchPokemon,
              child: Text('Buscar Pokémon'),
            ),
            SizedBox(height: 20),
            if (pokemonData.isNotEmpty)
              Column(
                children: <Widget>[
                  Image.network(pokemonData['sprites']['front_default']),
                  Text('Experiencia base: ${pokemonData['base_experience']}'),
                  Text('Habilidades:'),
                  ...pokemonData['abilities'].map<Widget>((ability) {
                    return Text('- ${ability['ability']['name']}');
                  }).toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}