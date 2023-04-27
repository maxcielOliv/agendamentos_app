// import 'dart:math';

// import 'package:agendamentos_app/database/models/agendamento.dart';
// import 'package:agendamentos_app/database/models/dao/agendamento_dao.dart';
// import 'package:agendamentos_app/screens/cadastro/agendamento_cadastro.dart';
// import 'package:agendamentos_app/screens/calendar/meeting.dart';
// import 'package:agendamentos_app/screens/calendar/meeting_datasource.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// class AgendamentoScreen extends StatefulWidget {
//   const AgendamentoScreen({super.key});

//   @override
//   State<AgendamentoScreen> createState() => _AgendamentoScreenState();
// }

// class _AgendamentoScreenState extends State<AgendamentoScreen> {
//   List<Color> _colorCollection = <Color>[];
//   MeetingDataSource? events;
//   final db = FirebaseFirestore.instance;

//   @override
//   void initState() {
//     _initializeEventColor();
//     getDataFromFireStore().then((results) {
//       SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//         setState(() {});
//       });
//     });
//     super.initState();
//   }

//   Future<void> getDataFromFireStore() async {
//     var snapShotsValue = await db.collection("agendamento").get();
//     final dao = AgendamentoDao();

//     final Random random = Random();
//     final List<Meeting> meentings = <Meeting>[];
//     setState(() {
//       events = MeetingDataSource(meentings);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Calendário'),
//       ),
//       body: SfCalendar(
//         view: CalendarView.month,
//         dataSource: events,
//         monthViewSettings: const MonthViewSettings(
//           appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
//           showAgenda: true,
//         ),
//         onTap: calendarTapped,
//       ),
//     );
//   }

//   void calendarTapped(CalendarTapDetails details) {
//     if (details.targetElement == CalendarElement.appointment ||
//         details.targetElement == CalendarElement.agenda) {
//       final Meeting meeting = details.appointments![0];

//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Container(child: const Text('Detalhes da Missão')),
//               // content: Text(
//               //     "Missão: ${meeting.eventName}\nPJ: ${meeting.pj}\nPromotor: ${meeting.promotor}\nInicio: ${meeting.from}\nFim: ${meeting.to}"),
//               actions: <Widget>[
//                 TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const AgendamentoCadastro(),
//                         ),
//                       );
//                     },
//                     child: const Text('close'))
//               ],
//             );
//           });
//     }
//   }

//   void _initializeEventColor() {
//     _colorCollection.add(const Color(0xFF0F8644));
//     _colorCollection.add(const Color(0xFF8B1FA9));
//     _colorCollection.add(const Color(0xFFD20100));
//     _colorCollection.add(const Color(0xFFFC571D));
//     _colorCollection.add(const Color(0xFF36B37B));
//     _colorCollection.add(const Color(0xFF01A1EF));
//     _colorCollection.add(const Color(0xFF3D4FB5));
//     _colorCollection.add(const Color(0xFFE47C73));
//     _colorCollection.add(const Color(0xFF636363));
//     _colorCollection.add(const Color(0xFF0A8043));
//   }
// }

// // class MeetingDataSource extends CalendarDataSource {
// //   MeetingDataSource(List<Meeting> source) {
// //     appointments = source;
// //   }

// //   @override
// //   DateTime getStartTime(int index) {
// //     return appointments![index].from;
// //   }

// //   @override
// //   DateTime getEndTime(int index) {
// //     return appointments![index].to;
// //   }

// //   @override
// //   String getSubject(int index) {
// //     return appointments![index].eventName;
// //   }

// //   @override
// //   Color getColor(int index) {
// //     return appointments![index].background;
// //   }

// //   String getPj(int index) {
// //     return appointments![index].pj.toString();
// //   }

// //   String getPromotor(int index) {
// //     return appointments![index].promotor.toString();
// //   }
// // }

// // class Meeting {
// //   String eventName;
// //   DateTime from;
// //   DateTime to;
// //   Color background;
// //   bool isAllDay;
// //   String? pj;
// //   String? promotor;

// //   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
// //       this.pj, this.promotor);
// // }
