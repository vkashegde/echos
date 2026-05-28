import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  PermissionHelper({OnAudioQuery? audioQuery})
      : _audioQuery = audioQuery ?? OnAudioQuery();

  final OnAudioQuery _audioQuery;

  Future<bool> requestStoragePermission() async {
    if (await _audioQuery.permissionsStatus()) {
      return true;
    }
    return _audioQuery.permissionsRequest();
  }

  Future<bool> ensurePermissions() async {
    final storage = await Permission.audio.request();
    if (storage.isGranted) return true;
    return requestStoragePermission();
  }
}
