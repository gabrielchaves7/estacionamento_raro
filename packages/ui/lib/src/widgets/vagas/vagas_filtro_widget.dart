import 'package:flutter/material.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/injection.dart';

class VagasFiltroWidget extends StatelessWidget {
  VagasFiltroWidget({Key? key}) : super(key: key);

  final VagasCubit _vagasCubit = getIt<VagasCubit>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  _vagasCubit.exibirVagasDisponiveis
                      ? Colors.blue
                      : Colors.white)),
          child: const Text(
            'Disponíveis',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            _vagasCubit.changeExibirVagasDisponiveis(
                exibirVagasDisponiveis: true);
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  !_vagasCubit.exibirVagasDisponiveis
                      ? Colors.blue
                      : Colors.white)),
          child: const Text(
            'Indisponíveis',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            _vagasCubit.changeExibirVagasDisponiveis(
                exibirVagasDisponiveis: false);
          },
        ),
      ],
    );
  }
}
