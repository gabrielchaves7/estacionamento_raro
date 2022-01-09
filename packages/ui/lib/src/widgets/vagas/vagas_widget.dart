import 'package:domain/estacionamento_raro_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/loading/loading_area_widget.dart';
import 'package:ui/src/widgets/loading/loading_widget.dart';
import 'package:ui/src/widgets/vagas/vaga_card_widget.dart';
import 'package:ui/src/widgets/vagas/vagas_filtro_widget.dart';

class VagasWidget extends StatelessWidget {
  VagasWidget({Key? key}) : super(key: key);

  final VagasCubit _vagasCubit = getIt<VagasCubit>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _vagasCubit.getVagas(),
      child: LoadingArea(
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
              } else if (state is VagaClosedErrorState) {
                return const Text('Ocorreu um erro ao atualizar a vaga.');
              }

              return Column(
                children: [
                  VagasFiltroWidget(),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 160,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: isLoading ? 2 : vagas.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Loading(
                          isLoading: isLoading,
                          child: isLoading
                              ? const VagaCardLoadingWidget()
                              : VagaCardWidget(vaga: vagas[index]),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
