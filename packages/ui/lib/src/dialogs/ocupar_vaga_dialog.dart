import 'package:domain/estacionamento_raro_entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/injection.dart';

class OcuparVagaDialog extends StatefulWidget {
  const OcuparVagaDialog({Key? key, required this.vaga}) : super(key: key);

  final Vaga vaga;

  @override
  OcuparVagaDialogState createState() {
    return OcuparVagaDialogState();
  }
}

class OcuparVagaDialogState extends State<OcuparVagaDialog> {
  final _formKey = GlobalKey<FormState>();
  final VagasCubit _vagasCubit = getIt<VagasCubit>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: const Text('Informe a placa'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor informe uma placa válida.';
                  } else if (value.length < 6) {
                    return 'A placa deve ter no mínimo 7 digítos.';
                  }

                  return null;
                },
              ),
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
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Marcando a vaga como ocupada...')),
                );
                _vagasCubit.updateVaga(
                    disponivel: !widget.vaga.disponivel, id: widget.vaga.id);
                Navigator.of(context).pop();
              }
            },
            child: const Text('confirmar'),
          ),
        ],
      ),
    );
  }
}
