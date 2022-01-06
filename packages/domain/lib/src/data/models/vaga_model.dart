import 'package:domain/src/domain/entities/vaga_entity.dart';
import 'package:domain/src/enum/tipo_vaga_enum.dart';

class VagaModel implements Vaga {
  VagaModel({
    required this.id,
    required this.disponivel,
    required this.tipoVaga,
  });

  VagaModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        disponivel = json['disponivel'],
        tipoVaga = TipoVagaEnum.values
            .firstWhere((e) => e.toString() == json['tipoVaga']);

  @override
  String id;

  @override
  bool disponivel;

  @override
  TipoVagaEnum tipoVaga;
}
