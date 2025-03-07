import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Acerca de')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/icons/personalme.jpg'),
              radius: 100,
            ),
            SizedBox(height: 20),
            _buildInfoText('Nestor Emilio Parra Rivas'),
            _buildInfoText('Correo: nestoremiliopr2004@gmail.com'),
            _buildInfoText('Teléfono: +18496319832'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
