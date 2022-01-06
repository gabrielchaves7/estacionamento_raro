import 'src/injection.dart';

class EstacionamentoRaroDomain {
  factory EstacionamentoRaroDomain() {
    return _instance;
  }

  EstacionamentoRaroDomain._() {
    configureDependencies();
  }

  static bool _initialized = false;
  static late EstacionamentoRaroDomain _instance;
  static void init() {
    if (!_initialized) {
      _instance = EstacionamentoRaroDomain._();
      _initialized = true;
    }
  }
}
