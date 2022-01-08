import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ui/estacionamento_raro_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estacionamento do João',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EstacionamentoRaroUiModule(),
    );
  }
}
