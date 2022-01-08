import 'package:domain/estacionamento_raro_entities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistroCardWidget extends StatelessWidget {
  const RegistroCardWidget({Key? key, required this.registro})
      : super(key: key);

  final Registro registro;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 0, right: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cardInfo("Placa", registro.placa),
                _cardInfo(
                    "Entrada",
                    DateFormat('dd/MM/yyyy HH:mm', 'pt_BR')
                        .format(registro.horarioEntrada)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cardInfo(
                    "Permanência",
                    _calcularTempoDePermanencia(
                        registro.horarioEntrada, registro.horarioSaida)),
                _cardInfo(
                    "Saída",
                    registro.horarioSaida != null
                        ? DateFormat('dd/MM/yyyy HH:mm', 'pt_BR')
                            .format(registro.horarioSaida!)
                        : "Aguardando"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _cardInfo(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(subtitle,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  String _calcularTempoDePermanencia(
      DateTime horarioEntrada, DateTime? horarioSaida) {
    horarioSaida = horarioSaida ?? DateTime.now();

    return _formatarDurationParaData(horarioSaida.difference(horarioEntrada));
  }

  String _formatarDurationParaData(Duration duration) {
    String tempoPermanencia = '${duration.inMinutes} minuto (s).';

    if (duration.inHours < 24 && duration.inHours > 0) {
      tempoPermanencia = '${duration.inHours} hora (s).';
    } else if (duration.inDays > 0) {
      int days = duration.inDays;
      int hours = duration.inHours - (days * 24);
      tempoPermanencia = '$days dia (s) e $hours hora (s).';
    }

    return tempoPermanencia;
  }
}

class RegistroCardLoadingWidget extends StatelessWidget {
  const RegistroCardLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 150,
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
