import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocalStorageRepository {
  final _kUuidKey = 'UUID';

  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  Future<void> uuid(UuidValue newValue) async {
    var preferences = await _preferences;
    await preferences.setString(_kUuidKey, newValue.uuid);
  }

  Future<UuidValue?> getUuid() async {
    var preferences = await _preferences;
    var value = preferences.getString(_kUuidKey);
    if (value == null) return null;
    return UuidValue(value);
  }

  Future<void> removeUuid() async {
    var preferences = await _preferences;
    await preferences.remove(_kUuidKey);
  }
}
