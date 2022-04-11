import 'package:localstore/localstore.dart';
import 'package:uuid/uuid.dart';

class LocalStorageRepository {
  final _kCollectionKey = 'PLANNING';
  final _kUuidKey = 'UUID-KEY';

  final db = Localstore.instance;

  set uuid(UuidValue newValue) {
    db.collection(_kCollectionKey).doc(_kUuidKey).set({
      _kUuidKey: newValue.uuid,
    });
  }

  Future<UuidValue?> getUuid() async {
    var value = await db.collection(_kCollectionKey).doc(_kUuidKey).get();
    if (value == null) return null;
    return UuidValue(value[_kUuidKey]);
  }

  removeUuid() {
    db.collection(_kCollectionKey).doc(_kUuidKey).delete();
  }
}
