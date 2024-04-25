import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Registry {
  Registry(this.name, this.datetime, this.kWh, this.kWhValue, this.total);

  final String name;
  final DateTime datetime;
  final double kWh;
  final double kWhValue;
  final double total;

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input.substring(0, 1).toUpperCase() + input.substring(1).toLowerCase();
  }

  String formattedDate() {
    initializeDateFormatting('es');
    final weekday = DateFormat.EEEE('es').format(datetime);
    final day = DateFormat.d('es').format(datetime);
    final month = DateFormat.MMM('es').format(datetime);
    final year = DateFormat.y('es').format(datetime);

    return '${capitalizeFirstLetter(weekday)} $day $month $year';
  }
}