import 'dart:convert';

import 'package:mamba/models/screen_arguments/host_landing_screen_arguments.dart';
import 'package:mamba/models/screen_arguments/join_landing_screen_arguments.dart';
import 'package:mamba/models/screen_arguments/spectator_landing_screen_arguments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocalStorageRepository {
  final _kUuidKey = 'UUID';
  final _kUsernameKey = 'USERNAME';
  final _kScreenArgumentsKey = 'SCREEN_ARGUMENTS';

  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  // UUID
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

  // Username
  Future<void> username(String newValue) async {
    var preferences = await _preferences;
    await preferences.setString(_kUsernameKey, newValue);
  }

  Future<String?> get getUsername async {
    var preferences = await _preferences;
    return preferences.getString(_kUsernameKey);
  }

  // Host screen arguments
  Future<void> hostLandingScreenArguments(
      HostLandingScreenArguments newValue) async {
    var preferences = await _preferences;
    var jsonValue = jsonEncode(newValue);
    await preferences.setString(_kScreenArgumentsKey, jsonValue);
  }

  Future<HostLandingScreenArguments?> get getHostLandingScreenArguments async {
    var preferences = await _preferences;
    var jsonValue = preferences.getString(_kScreenArgumentsKey);
    if (jsonValue == null) return null;
    return HostLandingScreenArguments.fromJson(jsonDecode(jsonValue));
  }

  // Join screen arguments
  Future<void> joinLandingScreenArguments(
      JoinLandingScreenArguments newValue) async {
    var preferences = await _preferences;
    var jsonValue = jsonEncode(newValue);
    await preferences.setString(_kScreenArgumentsKey, jsonValue);
  }

  Future<JoinLandingScreenArguments?> get getJoinLandingScreenArguments async {
    var preferences = await _preferences;
    var jsonValue = preferences.getString(_kScreenArgumentsKey);
    if (jsonValue == null) return null;
    return JoinLandingScreenArguments.fromJson(jsonDecode(jsonValue));
  }

  // Spectator screen arguments
  Future<void> spectatorLandingScreenArguments(
      SpectatorLandingScreenArguments newValue) async {
    var preferences = await _preferences;
    var jsonValue = jsonEncode(newValue);
    await preferences.setString(_kScreenArgumentsKey, jsonValue);
  }

  Future<SpectatorLandingScreenArguments?>
      get getSpectatorLandingScreenArguments async {
    var preferences = await _preferences;
    var jsonValue = preferences.getString(_kScreenArgumentsKey);
    if (jsonValue == null) return null;
    return SpectatorLandingScreenArguments.fromJson(jsonDecode(jsonValue));
  }
}
