import 'package:easy_localization/easy_localization.dart';

class UnitsTranslator {
  static String secondsToText(int seconds) {
    if (seconds < 60) {
      return 'units_translator_seconds'.tr();
    } else if (seconds < 3600) {
      return '${(seconds / 60).floor()} min';
    } else if (seconds < 86400) {
      return '${(seconds / 3600).floor()} h ${'i'.tr()} ${(seconds % 3600 / 60).floor()} min';
    } else {
      return '${(seconds / 86400).floor()} d, ${(seconds % 86400 / 3600).floor()} h ${'i'.tr()} ${(seconds % 3600 / 60).floor()} min';
    }
  }

  static String metersToText(int meters) {
    if (meters < 1000) {
      return '${meters / 100 * 100} m';
    } else {
      return '${(meters / 1000).floor()} km';
    }
  }
}
