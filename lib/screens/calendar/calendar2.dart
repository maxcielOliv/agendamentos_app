import 'package:agendamentos_app/screens/calendar/meeting.dart';
import 'package:agendamentos_app/screens/calendar/meeting_datasource.dart';
import 'package:agendamentos_app/utils/formatar_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  List<Meeting> _meetings = [];

  @override
  void initState() {
    super.initState();
    _getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: DataSource(_meetings),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
        onTap: calendarTapped,
      ),
    );
  }

  void _getAppointments() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('agendamento')
        .orderBy('data')
        .get();

    final List<DocumentSnapshot> documents = result.docs;
    //final DateTime today = DateTime.now();
    // final DateTime startTime = DateTime(2023, 4, 25, 9);
    //print(startTime);
    // final DateTime endTime = startTime.add(const Duration(hours: 2));
    setState(
      () {
        _meetings = documents
            .map(
              (doc) => Meeting(
                  from: (doc['horaInicio']?.toDate()),
                  //Timestamp(doc['horaInicio'], doc['horaInicio']).toDate(),
                  //DateTime.fromMillisecondsSinceEpoch(doc['horaInicio']),
                  to: (doc['horaTermino']?.toDate()),
                  //DateTime.fromMillisecondsSinceEpoch(doc['horaTermino']),
                  eventName: doc['local'],
                  background: const Color(0xFF0F8644),
                  description: doc['motorista'],
                  isAllDay: false),
            )
            .toList();
        // print(documents
        //     .map((e) => Timestamp(e['horaInicio'], e['horaInicio']).toDate()));
        // print(documents.map((e) => (formatarData(e['horaInicio']).toDate())));
      },
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Meeting meeting = details.appointments![0];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(child: const Text('Detalhes da Missão')),
            content: Text(
                "Missão: ${meeting.eventName}\nPJ: ${meeting.description}"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('close'))
            ],
          );
        },
      );
    }
  }
}
