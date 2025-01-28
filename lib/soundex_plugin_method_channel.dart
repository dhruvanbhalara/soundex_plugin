import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'soundex_plugin_platform_interface.dart';

/// An implementation of [SoundexPluginPlatform] that uses method channels.
class MethodChannelSoundexPlugin extends SoundexPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('soundex_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
