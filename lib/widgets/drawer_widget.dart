import 'package:flutter/material.dart';
import '../screens/gender_screen.dart';
import '../screens/age_screen.dart';
import '../screens/about_screen.dart';
import '../screens/universities_screen.dart';
import '../screens/weather_screen.dart';
import '../screens/pokemon_screen.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menú'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Predecir Género'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GenderScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Determinar Edad'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AgeScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Universidades por País'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UniversitiesScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Clima en RD'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Buscar Pokémon'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PokemonScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Acerca de'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}