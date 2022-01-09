import 'package:domain/estacionamento_raro_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/loading/loading_area_widget.dart';
import 'package:ui/src/widgets/loading/loading_widget.dart';
import 'package:ui/src/widgets/vagas/vaga_card_widget.dart';

class VagasWidget extends StatefulWidget {
  const VagasWidget({Key? key}) : super(key: key);

  @override
  State<VagasWidget> createState() => _VagasWidgetState();
}

class _VagasWidgetState extends State<VagasWidget> {
  final VagasCubit _vagasCubit = getIt<VagasCubit>();

  @override
  void initState() {
    super.initState();
    _vagasCubit.getVagas();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingArea(
      linearGradient: shimmerGradient,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
        child: BlocBuilder<VagasCubit, VagasState>(
          builder: (context, state) {
            List<Vaga> vagas = [];
            bool isLoading = state is VagasInitialState ||
                state is VagasLoadingState ||
                state is VagasErrorState;

            if (state is VagasLoadedState) {
              vagas = state.vagas;
            } else if (state is VagaUpdateErrorState) {
              return Text('Ocorreu um erro ao atualizar a vaga.');
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                crossAxisSpacing: 8,
                mainAxisSpacing: 20,
              ),
              itemCount: isLoading ? 4 : vagas.length,
              itemBuilder: (BuildContext context, int index) {
                return Loading(
                  isLoading: isLoading,
                  child: isLoading
                      ? const VagaCardLoadingWidget()
                      : VagaCardWidget(vaga: vagas[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
