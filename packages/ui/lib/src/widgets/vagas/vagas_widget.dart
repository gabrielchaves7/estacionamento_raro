import 'package:domain/estacionamento_raro_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/components/loading/loading_area_widget.dart';
import 'package:ui/src/widgets/components/loading/loading_widget.dart';
import 'package:ui/src/widgets/vagas/vaga_card_widget.dart';
import 'package:ui/src/widgets/vagas/vagas_filtro_widget.dart';
import 'package:ui/src/widgets/warning/warning_message_widget.dart';

class VagasWidget extends StatelessWidget {
  VagasWidget({Key? key}) : super(key: key);

  final VagasCubit _vagasCubit = getIt<VagasCubit>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _vagasCubit.getVagas(),
      child: LoadingArea(
        linearGradient: shimmerGradient,
        child: BlocBuilder<VagasCubit, VagasState>(
          builder: (context, state) {
            List<Vaga> vagas = [];
            bool showEmptyWarning = false;
            bool isLoading = state is VagasInitialState ||
                state is VagasLoadingState ||
                state is VagasErrorState;

            if (state is VagasLoadedState) {
              vagas = state.vagas;
              showEmptyWarning = vagas.isEmpty;
            }

            return Column(
              children: [
                if (state is VagaClosedErrorState ||
                    state is VagaOpenedErrorState)
                  const WarningMessageWidget(
                    title: 'Ocorreu um erro ao atualizar a vaga.',
                    subtitle: 'Tente novamente mais tarde.',
                  )
                else if (state is VagasErrorState)
                  const WarningMessageWidget(
                    title: 'Ocorreu um erro ao buscar as vagas.',
                    subtitle: 'Deslize para baixo para atualizar.',
                  )
                else if (showEmptyWarning)
                  WarningMessageWidget(
                    title:
                        'No momento não temos vagas ${_vagasCubit.exibirVagasDisponiveis ? "disponíveis" : "indisponíveis"} para serem exibidas.',
                  ),
                VagasFiltroWidget(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
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
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
