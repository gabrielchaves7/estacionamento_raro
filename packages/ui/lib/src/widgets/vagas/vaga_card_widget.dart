import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_enums.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/dialogs/ocupar_vaga_dialog.dart';

class VagaCardWidget extends StatelessWidget {
  const VagaCardWidget({Key? key, required this.vaga}) : super(key: key);

  final Vaga vaga;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return OcuparVagaDialog(
              vaga: vaga,
            );
          },
        );
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 8, bottom: 0, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                vaga.numero.toString(),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Icon(_vagaIcon(vaga.tipoVaga)),
            ],
          ),
        ),
      ),
    );
  }

  IconData _vagaIcon(TipoVagaEnum tipoVaga) {
    if (tipoVaga == TipoVagaEnum.moto) {
      return Icons.motorcycle;
    } else if (tipoVaga == TipoVagaEnum.carro) {
      return Icons.directions_car;
    } else {
      return Icons.directions_subway;
    }
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
