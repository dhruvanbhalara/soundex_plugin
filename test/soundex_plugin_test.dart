import 'package:flutter_test/flutter_test.dart';
import 'package:soundex_plugin/soundex_plugin.dart';
import 'package:soundex_plugin/soundex_plugin_platform_interface.dart';
import 'package:soundex_plugin/soundex_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSoundexPluginPlatform
    with MockPlatformInterfaceMixin
    implements SoundexPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SoundexPluginPlatform initialPlatform = SoundexPluginPlatform.instance;

  test('$MethodChannelSoundexPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSoundexPlugin>());
  });

  test('getPlatformVersion', () async {
    SoundexPlugin soundexPlugin = SoundexPlugin();
    MockSoundexPluginPlatform fakePlatform = MockSoundexPluginPlatform();
    SoundexPluginPlatform.instance = fakePlatform;

    expect(await soundexPlugin.getPlatformVersion(), '42');
  });
}
