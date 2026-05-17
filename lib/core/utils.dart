import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

void log(String tag, String msg) {
  debugPrint('[$tag] $msg');
}

String formatDate(DateTime dt, {String locale = 'ar'}) =>
    DateFormat('yyyy/MM/dd', 'en').format(dt);

String formatDateTime(DateTime dt, {String locale = 'ar'}) =>
    DateFormat('yyyy/MM/dd HH:mm', 'en').format(dt);
