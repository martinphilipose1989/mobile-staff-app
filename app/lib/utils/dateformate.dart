import 'package:intl/intl.dart';

extension DateFormate on DateTime {
  String dateFormatohhmmss() {
    try {
      return DateFormat('hh:mm:ss').format(this);
    } catch (e) {
      return '';
    }
  }
}

extension DateFormatExtension on String {
  String dateFormattoddMMyyyy() {
    try {
      DateTime dateTime = DateTime.parse(this);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  String dateFormatToDDMMYYYhhmma() {
    try {
      DateTime dateTime = DateTime.parse(this);
      return DateFormat('dd/MM/yyyy - hh:mma').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  String dateFormatToddMMMyyyhmma() {
    try {
      DateTime dateTime = DateTime.parse(this);
      return DateFormat('dd MMM yyyy h:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  String dateFormattoddMMMyyyy() {
    try {
      DateTime dateTime = DateTime.parse(this);
      return DateFormat('dd MMM yyyy').format(dateTime);
    } catch (e) {
      return "";
    }
  }

  String convertTo12HourFormat() {
    try {
      DateTime dateTime = DateFormat("HH:mm:ss").parse(this);
      String time12Hour = DateFormat("hh:mm:ss a").format(dateTime);
      return time12Hour;
    } catch (e) {
      return "";
    }
  }
}
