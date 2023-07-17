import 'package:agendamentos_app/screens/calendar/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DataSource extends CalendarDataSource {
  DataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  String getSubject(int index) => appointments![index].local;

  @override
  DateTime getStartTime(int index) => appointments![index].dataInicial;

  @override
  DateTime getEndTime(int index) => appointments![index].dataFinal;

  @override
  String getNotes(int index) => appointments![index].motorista;
}
