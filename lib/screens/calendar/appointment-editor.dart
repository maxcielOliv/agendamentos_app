import 'package:agendamentos_app/database/models/agendamento.dart';
import 'package:agendamentos_app/database/models/dao/agendamento_dao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentEditor extends StatefulWidget {
  const AppointmentEditor({super.key});

  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  final dao = AgendamentoDao();
  final _local = TextEditingController();
  final _motorista = TextEditingController();
  final _veiculo = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;
  late bool _isAllDay = false;
  late Agendamento agendamento = Agendamento(
      data: DateTime.now(),
      local: _local.text,
      motorista: _motorista.text,
      veiculo: _veiculo.text,
      horaInicio: _startDate,
      horaTermino: _endDate);

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    setState(() {
      _isAllDay = false;
      _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
      _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Novo Agendamento'),
            //backgroundColor: _colorCollection[_selectedColorIndex],
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  icon: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // final List<Meeting> meetings = <Meeting>[];
                    // if (_selectedAppointment != null &&
                    //     _formKey.currentState!.validate()) {
                    //   _events.appointments!.removeAt(
                    //     _events.appointments!.indexOf(_selectedAppointment),
                    //   );
                    //   _events.notifyListeners(
                    //     CalendarDataSourceAction.remove,
                    //     <Meeting>[]..add(_selectedAppointment!),
                    //   );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Cadastro realizado com sucesso')),
                    );
                    dao.salvar(agendamento);
                  }
                  // meetings.add(Meeting(
                  //   from: _startDate,
                  //   to: _endDate,
                  //   background: _colorCollection[_selectedColorIndex],
                  //   description: _motorista,
                  //   isAllDay: _isAllDay,
                  //   eventName: _local == '' ? '(No title)' : _local,
                  // ),);

                  //_events.appointments!.add(meetings[0]);

                  //_events.notifyListeners(
                  // CalendarDataSourceAction.add, meetings);
                  // _selectedAppointment = null;

                  //Navigator.pop(context);
                  //},)
                  ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: <Widget>[
                  ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    leading: const Text(''),
                    title: TextField(
                      controller: TextEditingController(text: _local.text),
                      onChanged: (String value) {
                        _local.text = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Adicione o Local',
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),
                  // ListTile(
                  //   contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  //   leading: const Icon(
                  //     Icons.access_time,
                  //     color: Colors.black54,
                  //   ),
                  //   title: Row(
                  //     children: <Widget>[
                  //       const Expanded(
                  //         child: Text('Dia Todo'),
                  //       ),
                  //       Expanded(
                  //         child: Align(
                  //           alignment: Alignment.centerRight,
                  //           child: Switch(
                  //             value: _isAllDay,
                  //             onChanged: (bool value) {
                  //               setState(() {
                  //                 _isAllDay = value;
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // ListTile(
                  //   contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  //   leading: const Text(''),
                  //   title: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: <Widget>[
                  //       Expanded(
                  //         flex: 7,
                  //         child: GestureDetector(
                  //           child: Text(
                  //               DateFormat('EEE, MMM dd yyyy')
                  //                   .format(_startDate),
                  //               textAlign: TextAlign.left),
                  //           onTap: () async {
                  //             final DateTime? date = await showDatePicker(
                  //               context: context,
                  //               initialDate: _startDate,
                  //               firstDate: DateTime(1900),
                  //               lastDate: DateTime(2100),
                  //             );

                  //             if (date != null && date != _startDate) {
                  //               setState(
                  //                 () {
                  //                   final Duration difference =
                  //                       _endDate.difference(_startDate);
                  //                   _startDate = DateTime(
                  //                       date.year,
                  //                       date.month,
                  //                       date.day,
                  //                       _startTime.hour,
                  //                       _startTime.minute,
                  //                       0);
                  //                   _endDate = _startDate.add(difference);
                  //                   _endTime = TimeOfDay(
                  //                       hour: _endDate.hour,
                  //                       minute: _endDate.minute);
                  //                 },
                  //               );
                  //             }
                  //           },
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 3,
                  //         child: _isAllDay
                  //             ? const Text('')
                  //             : GestureDetector(
                  //                 child: Text(
                  //                   DateFormat('hh:mm a').format(_startDate),
                  //                   textAlign: TextAlign.right,
                  //                 ),
                  //                 onTap: () async {
                  //                   final TimeOfDay? time =
                  //                       await showTimePicker(
                  //                           context: context,
                  //                           initialTime: TimeOfDay(
                  //                               hour: _startTime.hour,
                  //                               minute: _startTime.minute));

                  //                   if (time != null && time != _startTime) {
                  //                     setState(() {
                  //                       _startTime = time;
                  //                       final Duration difference =
                  //                           _endDate.difference(_startDate);
                  //                       _startDate = DateTime(
                  //                           _startDate.year,
                  //                           _startDate.month,
                  //                           _startDate.day,
                  //                           _startTime.hour,
                  //                           _startTime.minute,
                  //                           0);
                  //                       _endDate = _startDate.add(difference);
                  //                       _endTime = TimeOfDay(
                  //                           hour: _endDate.hour,
                  //                           minute: _endDate.minute);
                  //                     });
                  //                   }
                  //                 },
                  //               ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // ListTile(
                  //   contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  //   leading: const Text(''),
                  //   title: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: <Widget>[
                  //       Expanded(
                  //         flex: 7,
                  //         child: GestureDetector(
                  //             child: Text(
                  //               DateFormat('EEE, MMM dd yyyy').format(_endDate),
                  //               textAlign: TextAlign.left,
                  //             ),
                  //             onTap: () async {
                  //               final DateTime? date = await showDatePicker(
                  //                 context: context,
                  //                 initialDate: _endDate,
                  //                 firstDate: DateTime(1900),
                  //                 lastDate: DateTime(2100),
                  //               );

                  //               if (date != null && date != _endDate) {
                  //                 setState(() {
                  //                   final Duration difference =
                  //                       _endDate.difference(_startDate);
                  //                   _endDate = DateTime(
                  //                       date.year,
                  //                       date.month,
                  //                       date.day,
                  //                       _endTime.hour,
                  //                       _endTime.minute,
                  //                       0);
                  //                   if (_endDate.isBefore(_startDate)) {
                  //                     _startDate =
                  //                         _endDate.subtract(difference);
                  //                     _startTime = TimeOfDay(
                  //                         hour: _startDate.hour,
                  //                         minute: _startDate.minute);
                  //                   }
                  //                 });
                  //               }
                  //             }),
                  //       ),
                  //       Expanded(
                  //         flex: 3,
                  //         child: _isAllDay
                  //             ? const Text('')
                  //             : GestureDetector(
                  //                 child: Text(
                  //                   DateFormat('hh:mm a').format(_endDate),
                  //                   textAlign: TextAlign.right,
                  //                 ),
                  //                 onTap: () async {
                  //                   final TimeOfDay? time =
                  //                       await showTimePicker(
                  //                           context: context,
                  //                           initialTime: TimeOfDay(
                  //                               hour: _endTime.hour,
                  //                               minute: _endTime.minute));

                  //                   if (time != null && time != _endTime) {
                  //                     setState(
                  //                       () {
                  //                         _endTime = time;
                  //                         final Duration difference =
                  //                             _endDate.difference(_startDate);
                  //                         _endDate = DateTime(
                  //                             _endDate.year,
                  //                             _endDate.month,
                  //                             _endDate.day,
                  //                             _endTime.hour,
                  //                             _endTime.minute,
                  //                             0);
                  //                         if (_endDate.isBefore(_startDate)) {
                  //                           _startDate =
                  //                               _endDate.subtract(difference);
                  //                           _startTime = TimeOfDay(
                  //                               hour: _startDate.hour,
                  //                               minute: _startDate.minute);
                  //                         }
                  //                       },
                  //                     );
                  //                   }
                  //                 },
                  //               ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),
                  // ListTile(
                  //   contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  //   leading: Icon(Icons.lens,
                  //       color: _colorCollection[_selectedColorIndex]),
                  //   title: Text(
                  //     _colorNames[_selectedColorIndex],
                  //   ),
                  //   onTap: () {
                  //     showDialog<Widget>(
                  //       context: context,
                  //       barrierDismissible: true,
                  //       builder: (BuildContext context) {
                  //         return _ColorPicker();
                  //       },
                  //     ).then(
                  //       (dynamic value) => setState(
                  //         () {},
                  //       ),
                  //     );
                  //   },
                  // ),
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(5),
                    leading: const Icon(
                      Icons.subject,
                      color: Colors.black87,
                    ),
                    title: TextField(
                      controller: TextEditingController(text: _motorista.text),
                      onChanged: (String value) {
                        _motorista.text = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Motorista',
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(5),
                    leading: const Icon(
                      Icons.subject,
                      color: Colors.black87,
                    ),
                    title: TextField(
                      controller: TextEditingController(text: _veiculo.text),
                      onChanged: (String value) {
                        _veiculo.text = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Veiculo',
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          //   child: Stack(
          //     children: <Widget>[_getAppointmentEditor(context)],
          //   ),
          // ),
          // floatingActionButton:
          //_selectedAppointment == null
          // ? const Text('')
          //FloatingActionButton(
          // onPressed: () {
          // if (_selectedAppointment != null) {
          //   _events.appointments!.removeAt(
          //       _events.appointments!.indexOf(_selectedAppointment));
          //   _events.notifyListeners(CalendarDataSourceAction.remove,
          //       <Meeting>[]..add(_selectedAppointment!));
          //   _selectedAppointment = null;
          //   Navigator.pop(context);
          // }
          // },
          // child: const Icon(Icons.delete_outline, color: Colors.white),
          // backgroundColor: Colors.red,
          //),
          ),
    );
  }

  // String getTile() {
  //   return _local.isEmpty ? 'Novo Agendamento' : 'Event details';
  // }
}
