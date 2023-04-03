import '../promotoria.dart';
import 'dao.dart';

class UnidadeDao extends Dao<Promotoria> {
  @override
  Future<Promotoria?> get(String id) async {
    final res = await db.collection('promotoria').doc(id).get();
    return res.exists ? Promotoria.fromFirestore(res) : null;
  }

  @override
  Future<List<Promotoria>> getAll() async {
    final res = await db.collection('promotoria').get();
    return res.docs.map((e) => Promotoria.fromFirestore(e)).toList();
  }
}