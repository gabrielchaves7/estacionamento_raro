import 'package:domain/estacionamento_raro_entities.dart';
import 'package:flutter/material.dart';

class VagaCardWidget extends StatelessWidget {
  const VagaCardWidget({Key? key, required this.vaga}) : super(key: key);

  final Vaga vaga;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 0, right: 16),
        child: Column(
          children: const [Icon(Icons.directions_car)],
        ),
      ),
    );
  }
}

class VagaCardLoadingWidget extends StatelessWidget {
  const VagaCardLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            width: 1, //                   <--- border width here
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
