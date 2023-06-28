import 'package:agendamentos_app/screens/calendar/agendamento_Editor.dart';
import 'package:agendamentos_app/screens/calendar/meeting.dart';
import 'package:agendamentos_app/screens/calendar/meeting_datasource.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  List<Meeting> _meetings = [];
  CalendarController calendarController = CalendarController();
  @override
  void initState() {
    super.initState();
    _getAppointments();
  }

  void _getAppointments() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('agendamento')
        .orderBy('data')
        .get();

    final List<DocumentSnapshot> documents = result.docs;
    setState(
      () {
        _meetings = documents
            .map(
              (doc) => Meeting(
                  horaInicio: (doc['horaInicio']?.toDate()),
                  horaTermino: (doc['horaTermino']?.toDate()),
                  local: doc['local'],
                  background: const Color(0xFF0F8644),
                  motorista: doc['motorista'],
                  isAllDay: false),
            )
            .toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DropdownPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SfCalendar(
        view: CalendarView.month,
        controller: calendarController,
        allowedViews: const [
          CalendarView.week,
          CalendarView.timelineWeek,
          CalendarView.month
        ],
        dataSource: DataSource(_meetings),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true,
            agendaItemHeight: 70,
            agendaViewHeight: 100),
        onTap: calendarTapped,
        //onLongPress: calendarLongTapped,
        //onViewChanged: (viewChangedDetails) => calendarTapped,
        appointmentBuilder: (context, calendarAppointmentDetails) {
          final Meeting meeting = calendarAppointmentDetails.appointments.first;
          return Container(
            color: meeting.background.withOpacity(0.8),
            child: Text(
              meeting.motorista,
              style: const TextStyle(color: Colors.black),
            ),
          );
        },
      ),
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
            title: const Text('Detalhes da Missão'),
            content: Text(
                "Missão: ${meeting.local}\nMotorista: ${meeting.motorista}"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              )
            ],
          );
        },
      );
    }
  }

  // void calendarTapped(CalendarTapDetails details) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       //builder: (context) => const AppointmentForm(),
  //       builder: (context) => const AppointmentEditor(),
  //     ),
  //   );
  // }
}
