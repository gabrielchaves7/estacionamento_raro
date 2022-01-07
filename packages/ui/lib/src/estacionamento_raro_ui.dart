import 'package:domain/estacionamento_raro_domain.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/pages/home_page.dart';

import 'injection.dart';

class EstacionamentoRaroUiModule extends StatefulWidget {
  EstacionamentoRaroUiModule() : super();

  @override
  _EstacionamentoRaroUiModuleState createState() =>
      _EstacionamentoRaroUiModuleState();
}

class _EstacionamentoRaroUiModuleState
    extends State<EstacionamentoRaroUiModule> {
  @override
  void initState() {
    super.initState();
    configureDependencies();
    EstacionamentoRaroDomain.init();
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage(
      title: 'titulo ai',
    );
  }
}
