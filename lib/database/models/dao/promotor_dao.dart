import 'package:agendamentos_app/database/models/dao/dao.dart';
import 'package:agendamentos_app/database/models/promotor.dart';

class PromotorDao extends Dao<Promotor> {
  @override
  Future<Promotor?> get(String id) async {
    final res = await db.collection('promotor').doc(id).get();
    return res.exists ? Promotor.fromFirestore(res) : null;
  }

  @override
  Future<List<Promotor>> getAll() async {
    final res = await db.collection('promotor').get();
    return res.docs.map((e) => Promotor.fromFirestore(e)).toList();
  }

  Stream<List<Promotor>> getAllStream() async* {
    yield* db
        .collection('promotor')
        .snapshots()
        .map((e) => e.docs.map((e) => Promotor.fromFirestore(e)).toList());
  }
}
