import 'package:flutter/material.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/components/filter_button.dart';

class VagasFiltroWidget extends StatelessWidget {
  VagasFiltroWidget({Key? key}) : super(key: key);

  final VagasCubit _vagasCubit = getIt<VagasCubit>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _vagaFilterButton('Disponíveis', true),
          _vagaFilterButton('Indisponíveis', false),
        ],
      ),
    );
  }

  _vagaFilterButton(String text, bool exibirVagasDisponiveis) {
    return FilterButton(
      onPressedCallback: () => _vagasCubit.changeExibirVagasDisponiveis(
          exibirVagasDisponiveis: exibirVagasDisponiveis),
      text: text,
      selected: _vagasCubit.exibirVagasDisponiveis == exibirVagasDisponiveis,
    );
  }
}
