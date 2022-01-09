import 'package:domain/estacionamento_raro_entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/injection.dart';

class DesocuparVagaDialog extends StatelessWidget {
  DesocuparVagaDialog({Key? key, required this.vaga}) : super(key: key);

  final Vaga vaga;
  final VagasCubit _vagasCubit = getIt<VagasCubit>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deseja realmente desocupar a vaga ${vaga.numero}?"),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Desocupando a vaga ${vaga.numero}...',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            _vagasCubit.openVaga(vagaId: vaga.id, registroId: vaga.registroId!);
            Navigator.of(context).pop();
          },
          child: const Text('confirmar'),
        ),
      ],
    );
  }
}
