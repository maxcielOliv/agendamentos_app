import '../unidade.dart';
import 'dao.dart';

class UnidadeDao extends Dao<Unidade> {
  @override
  Future<Unidade?> get(String id) async {
    final res = await db.collection('unidade').doc(id).get();
    return res.exists ? Unidade.fromFirestore(res) : null;
  }

  @override
  Future<List<Unidade>> getAll() async {
    final res = await db.collection('unidade').get();
    return res.docs.map((e) => Unidade.fromFirestore(e)).toList();
  }
}
