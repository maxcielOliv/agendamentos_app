import 'package:flutter/material.dart';

class Meeting {
  Meeting(
      {required this.horaInicio,
      required this.horaTermino,
      this.background = Colors.green,
      this.isAllDay = false,
      this.local = '',
      this.startTimeZone = '',
      this.endTimeZone = '',
      this.motorista = ''});

  final String local;
  final DateTime horaInicio;
  final DateTime horaTermino;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String motorista;
}
