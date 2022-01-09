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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
            subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
            button: TextStyle(fontSize: 16.0)),
      ),
      home: const EstacionamentoRaroUiModule(),
    );
  }
}
