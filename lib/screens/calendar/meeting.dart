class Meeting {
  Meeting(
      {this.local = '',
      required this.dataInicial,
      required this.dataFinal,
      this.horaInicio,
      this.horaTermino,
      this.motorista = ''});

  final String local;
  final DateTime dataInicial;
  final DateTime dataFinal;
  final DateTime? horaInicio;
  final DateTime? horaTermino;
  final String motorista;
}
