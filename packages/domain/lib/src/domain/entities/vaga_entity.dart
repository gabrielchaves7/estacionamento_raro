import 'package:domain/src/enum/tipo_vaga_enum.dart';

class Vaga {
  Vaga({
    required this.id,
    required this.disponivel,
    required this.tipoVaga,
  });

  String id;
  bool disponivel;
  TipoVagaEnum tipoVaga;
}
