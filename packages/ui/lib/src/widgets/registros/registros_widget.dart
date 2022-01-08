import 'package:domain/estacionamento_raro_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/bloc/registro_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/loading/loading_area_widget.dart';
import 'package:ui/src/widgets/loading/loading_widget.dart';
import 'package:ui/src/widgets/registros/registro_card_widget.dart';

class RegistrosWidget extends StatefulWidget {
  const RegistrosWidget({Key? key}) : super(key: key);

  @override
  State<RegistrosWidget> createState() => _RegistrosWidgetState();
}

class _RegistrosWidgetState extends State<RegistrosWidget> {
  final RegistroCubit _registroCubit = getIt<RegistroCubit>();

  @override
  void initState() {
    super.initState();
    _registroCubit.getRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingArea(
      linearGradient: shimmerGradient,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
        child: BlocProvider(
          create: (_) => _registroCubit,
          child: BlocBuilder<RegistroCubit, RegistroState>(
            builder: (context, state) {
              List<Registro> registros = [];
              bool isLoading = state is RegistroInitialState ||
                  state is RegistroLoadingState ||
                  state is RegistroErrorState;

              if (state is RegistroLoadedState) {
                registros = state.registros;
              }

              return ListView.builder(
                itemCount: isLoading ? 2 : registros.length,
                itemBuilder: (BuildContext context, int index) {
                  return Loading(
                    isLoading: isLoading,
                    child: isLoading
                        ? const RegistroCardLoadingWidget()
                        : RegistroCardWidget(registro: registros[index]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
