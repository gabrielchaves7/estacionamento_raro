import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/bloc/registro/registro_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/components/buttons/filter_button.dart';
import 'package:ui/src/widgets/components/loading/loading_area_widget.dart';
import 'package:ui/src/widgets/components/loading/loading_widget.dart';
import 'package:ui/src/widgets/registros/registro_card_widget.dart';
import 'package:ui/src/widgets/warning/warning_message_widget.dart';

class RegistrosWidget extends StatelessWidget {
  RegistrosWidget({Key? key}) : super(key: key);

  final RegistroCubit _registroCubit = getIt<RegistroCubit>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _registroCubit.getRegistros(),
      child: LoadingArea(
        linearGradient: shimmerGradient,
        child: BlocBuilder<RegistroCubit, RegistroState>(
          builder: (context, state) {
            List<Registro> registros = [];
            bool isLoading = state is RegistroInitialState ||
                state is RegistroLoadingState ||
                state is RegistroErrorState;

            if (state is RegistroLoadedState) {
              registros = state.registros;
            }

            return Column(
              children: [
                if (state is RegistroErrorState)
                  const WarningMessageWidget(
                    title: 'Ocorreu um erro ao buscar os registros.',
                    subtitle: 'Deslize para baixo para atualizar.',
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _registroFilterButton(DateFilterEnum.oneDay, '1 D'),
                    _registroFilterButton(DateFilterEnum.threeDays, '3 D'),
                    _registroFilterButton(DateFilterEnum.sevenDays, '7 D'),
                    _registroFilterButton(DateFilterEnum.thirtyDays, '30 D'),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                    child: ListView.builder(
                      itemCount: isLoading ? 2 : registros.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Loading(
                          isLoading: isLoading,
                          child: isLoading
                              ? const RegistroCardLoadingWidget()
                              : RegistroCardWidget(registro: registros[index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _registroFilterButton(DateFilterEnum dateFilter, String text) {
    return FilterButton(
        selected: _registroCubit.dateFilter == dateFilter,
        onPressedCallback: () => _registroCubit.updateFilterDate(dateFilter),
        text: text);
  }
}
