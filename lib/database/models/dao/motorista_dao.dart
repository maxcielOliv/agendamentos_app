import 'package:agendamentos_app/database/models/dao/dao.dart';
import 'package:agendamentos_app/database/models/motorista.dart';

class MotoristaDao extends Dao<Motorista> {
  @override
  Future<Motorista?> get(String id) async {
    final res = await db.collection('motorista').doc(id).get();
    return res.exists ? Motorista.fromFirestore(res) : null;
  }

  @override
  Future<List<Motorista>> getAll() async {
    final res = await db.collection('motorista').get();
    return res.docs.map((e) => Motorista.fromFirestore(e)).toList();
  }
}
