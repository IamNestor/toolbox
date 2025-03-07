import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic> weatherData = {};
  bool isLoading = true;
  String errorMessage = '';

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=Santo Domingo,DO&appid=733851cc09ec1a09d576937abd92ba56&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['main'] != null) {
          setState(() {
            weatherData = data;
          });
        } else {
          setState(() {
            errorMessage = 'No se encontraron datos del clima.';
          });
        }
      } else {
        setState(() {
          errorMessage =
              'Error al obtener los datos del clima. Código: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clima en RD')),
      body: Center(
        child:
            isLoading
                ? CircularProgressIndicator()
                : errorMessage.isNotEmpty
                ? Text(errorMessage, style: TextStyle(color: Colors.red))
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Temperatura: ${weatherData['main']['temp']}°C'),
                    Text('Humedad: ${weatherData['main']['humidity']}%'),
                    Text(
                      'Condición: ${weatherData['weather'][0]['description']}',
                    ),
                  ],
                ),
      ),
    );
  }
}
