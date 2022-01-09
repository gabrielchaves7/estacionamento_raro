import 'package:domain/estacionamento_raro_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/widgets/loading/loading_area_widget.dart';
import 'package:ui/src/widgets/loading/loading_container_widget.dart';
import 'package:ui/src/widgets/loading/loading_widget.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingArea(
      linearGradient: shimmerGradient,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
        child: Column(
          children: [
            const Text(
              "Resumo",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                BlocBuilder<VagasCubit, VagasState>(
                  builder: (context, state) {
                    List<Vaga> vagas = [];
                    bool isLoading = state is VagasInitialState ||
                        state is VagasLoadingState ||
                        state is VagasErrorState;
                    if (state is VagasLoadedState) {
                      vagas = state.vagas;
                    }

                    return Loading(
                      isLoading: isLoading,
                      child: isLoading
                          ? const LoadingContainerWidget(width: 50, height: 10)
                          : Text(
                              vagas.length.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
