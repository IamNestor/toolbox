import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class WordPressScreen extends StatefulWidget {
  @override
  _WordPressScreenState createState() => _WordPressScreenState();
}

class _WordPressScreenState extends State<WordPressScreen> {
  List<dynamic> posts = [];
  bool isLoading = true;
  String errorMessage = '';

  // URL de la API de WordPress
  final String wordPressUrl = 'https://wordpress.org/news/wp-json/wp/v2/posts';

  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse('$wordPressUrl?per_page=3'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          posts = data;
        });
      } else {
        setState(() {
          errorMessage = 'Error al obtener las noticias. Código: ${response.statusCode}';
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
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Últimas Noticias de WordPress'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo de WordPress
                            Image.network(
                              'https://s.w.org/style/images/about/WordPress-logotype-standard.png', // Logo de WordPress
                              height: 50,
                            ),
                            SizedBox(height: 10),
                            Text(
                              post['title']['rendered'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              post['excerpt']['rendered']
                                  .replaceAll('<p>', '')
                                  .replaceAll('</p>', ''),
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                final url = post['link'];
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('No se pudo abrir el enlace')),
                                  );
                                }
                              },
                              child: Text('Visitar'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}