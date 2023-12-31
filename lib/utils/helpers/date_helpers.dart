import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('dd MMM yyyy').format(date);
}

String getMonth(DateTime date) {
  return DateFormat('MMM').format(date);
}

String getFullMonth(DateTime date) {
  return DateFormat('MMMM').format(date);
}
