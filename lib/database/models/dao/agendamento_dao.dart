import '../agendamento.dart';
import 'dao.dart';

class AgendamentoDao extends Dao<Agendamento> {
  @override
  Future<Agendamento?> get(String id) async {
    final res = await db.collection('agendamento').doc(id).get();
    return res.exists ? Agendamento.fromFirestore(res) : null;
  }

  @override
  Future<List<Agendamento>> getAll() async {
    final res = await db.collection('agendamento').get();
    return res.docs.map((e) => Agendamento.fromFirestore(e)).toList();
  }

}