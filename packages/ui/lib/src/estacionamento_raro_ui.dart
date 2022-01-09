import 'package:domain/estacionamento_raro_domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ui/src/pages/home_page.dart';

import 'injection.dart';

class EstacionamentoRaroUiModule extends StatefulWidget {
  const EstacionamentoRaroUiModule({Key? key}) : super(key: key);

  @override
  _EstacionamentoRaroUiModuleState createState() =>
      _EstacionamentoRaroUiModuleState();
}

class _EstacionamentoRaroUiModuleState
    extends State<EstacionamentoRaroUiModule> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    configureDependencies();
    EstacionamentoRaroDomain.init();
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage(
      title: 'Estacionamento',
    );
  }
}
