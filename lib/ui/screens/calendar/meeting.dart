
class Meeting {
  Meeting(
      {this.local = '',
      required this.dataInicial,
      required this.dataFinal,
      this.horaInicio,
      this.horaTermino,
      this.motorista = '',
      this.usuario = '',
      //this.cor
      this.veiculo = ''});

  final String local;
  final DateTime dataInicial;
  final DateTime dataFinal;
  final DateTime? horaInicio;
  final DateTime? horaTermino;
  final String motorista;
  final String usuario;
  final String veiculo;
  // final Color? cor;
}
