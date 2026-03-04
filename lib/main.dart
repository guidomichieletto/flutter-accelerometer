import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Password Generator')),
        body: PasswordGeneratorWidget(),
      ),
    );
  }
}

class PasswordGeneratorWidget extends StatefulWidget {
  @override
  _PasswordGeneratorWidgetState createState() => _PasswordGeneratorWidgetState();
}

class _PasswordGeneratorWidgetState extends State<PasswordGeneratorWidget> {
  TextEditingController _passwordLengthController = TextEditingController(text: '12');
  bool _isGenerating = false;
  String _displayedPassword = '';
  String _validPassword = '';
  String _tempPassword = '';

  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    _accelerometerSubscription = accelerometerEventStream().listen((AccelerometerEvent event) {
      if (_isGenerating) {

        int desiredLength = int.tryParse(_passwordLengthController.text) ?? 12;
        _tempPassword += _generateCharFromMotion(event);
        
        setState(() {
          _displayedPassword = _tempPassword;
        });

        if (_tempPassword.length >= desiredLength) {  
          _validPassword = _tempPassword.substring(0, desiredLength);
          _tempPassword = '';
        } 
      }
    });
  }

  String _generateCharFromMotion(AccelerometerEvent event) {
    // Semplice algoritmo di generazione password basato sui valori dell'accelerometro
    String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()';

    int index = ((event.x.abs() + event.y.abs() + event.z.abs()) * 1000).toInt() % chars.length;
    return chars[index];
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  void _buttonClick() {
    setState(() {
      _isGenerating = !_isGenerating;
      _displayedPassword = _validPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Benvenuto in Password Generator',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Muovi il telefono nello spazio per generare una password casuale',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            TextField(
              controller: _passwordLengthController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Lunghezza password (default 12)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'La tua password:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            SelectableText(
              _displayedPassword,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _buttonClick,
              child: Text(_isGenerating ? 'Stop generazione' : 'Inizia generazione'),
            ),
          ],
        ),
      ),
    );
  }
}