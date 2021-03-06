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
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardInfo(context, "Placa", registro.placa),
                  _cardInfo(
                      context,
                      "Entrada",
                      DateFormat('dd/MM/yyyy HH:mm')
                          .format(registro.horarioEntrada)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardInfo(
                      context,
                      "Permanência",
                      _getPermanencia(
                          registro.horarioEntrada, registro.horarioSaida)),
                  _cardInfo(
                      context,
                      "Saída",
                      registro.horarioSaida != null
                          ? DateFormat('dd/MM/yyyy HH:mm')
                              .format(registro.horarioSaida!)
                          : "Aguardando"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardInfo(BuildContext context, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(subtitle, style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
    );
  }

  String _getPermanencia(DateTime horarioEntrada, DateTime? horarioSaida) {
    horarioSaida = horarioSaida ?? DateTime.now();

    return _formatDurationToDate(horarioSaida.difference(horarioEntrada));
  }

  String _formatDurationToDate(Duration duration) {
    String permanencia = '${duration.inMinutes} minuto (s).';

    if (duration.inHours < 24 && duration.inHours > 0) {
      permanencia = '${duration.inHours} hora (s).';
    } else if (duration.inDays > 0) {
      int days = duration.inDays;
      int hours = duration.inHours - (days * 24);
      permanencia = '$days dia (s) e $hours hora (s).';
    }

    return permanencia;
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
