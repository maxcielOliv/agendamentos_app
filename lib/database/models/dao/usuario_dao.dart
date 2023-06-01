import 'package:agendamentos_app/database/models/dao/dao.dart';
import 'package:agendamentos_app/database/models/usuario.dart';

class UsuarioDao2 extends Dao<Usuario> {
  @override
  Future<Usuario?> get(String id) async {
    final res = await db.collection('usuario').doc(id).get();
    return res.exists ? Usuario.fromFirestore(res) : null;
  }

  @override
  Future<List<Usuario>> getAll() async {
    final res = await db.collection('usuario').get();
    return res.docs.map((e) => Usuario.fromFirestore(e)).toList();
  }

  Stream<List<Usuario>> getAllStream() async* {
    yield* db
        .collection('usuario')
        .snapshots()
        .map((e) => e.docs.map((e) => Usuario.fromFirestore(e)).toList());
  }
}
