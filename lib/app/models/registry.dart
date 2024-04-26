import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Registry {
  Registry(this.name, this.datetime, this.kWh, this.kWhValue, this.total);
  Registry.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    datetime = DateTime.parse(json['datetime']);
    kWh = double.parse(json['kwh'].toStringAsFixed(2));
    kWhValue = json['kwhval'];
    total = double.parse(json['total'].toStringAsFixed(2));
  }

  late final String name;
  late final DateTime datetime;
  late final double kWh;
  late final double kWhValue;
  late final double total;

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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'datetime': datetime.toString(),
      'kwh': kWh,
      'kwhval': kWhValue,
      'total': total
    };
  }
}