part of '../local_pub.dart';

class AudioManager {
  static AudioManager? instance;
  FlutterTts? _tts;

  BuildContext mContext;
  String? language;

  AudioManager(this.mContext, {bool isIOS = false}) {
    _tts = FlutterTts();
    kIsWeb
        ? _forWeb()
        : Platform.isIOS
            ? _forIOS()
            : _forAndroid();
  }

  _forAndroid() async {
    const selectedLanguage = 'en-US';

    if (selectedLanguage == 'ar-SA') {
      _tts!.setLanguage('ar');
    } else if (selectedLanguage == 'ur-PK') {
      _tts!.setLanguage('ur-PK');
    } else if (selectedLanguage == 'el-GR') {
      _tts!.setLanguage('el-GR');
    } else {
      _tts!.setLanguage('en-US');
    }
    _tts!.setSpeechRate(0.4);
    _tts!.setPitch(1.0);
    _tts!.setQueueMode(1);
  }

  _forWeb() async {
    const selectedLanguage = 'en-US';

    if (selectedLanguage == 'ar-SA') {
      _tts!.setLanguage('ar');
    } else if (selectedLanguage == 'ur-PK') {
      _tts!.setLanguage('ur-PK');
    } else if (selectedLanguage == 'el-GR') {
      _tts!.setLanguage('el-GR');
    } else {
      _tts!.setLanguage('en-US');
    }
    _tts!.setSpeechRate(0.4);
    _tts!.setPitch(1.0);
    // _tts!.setQueueMode(1);
  }

  _forIOS() async {
    const selectedLanguage = 'en-US';

    if (selectedLanguage == 'ar-SA') {
      _tts!.setLanguage('ar');
    } else {
      _tts!.setLanguage('en-US');
    }
    _tts!.setSpeechRate(0.5);
    _tts!.setPitch(1.3);
    // _tts!.setQueueMode(1);
    await _tts!.setIosAudioCategory(IosTextToSpeechAudioCategory.playback,
        [IosTextToSpeechAudioCategoryOptions.defaultToSpeaker]);
    await _tts!.setSharedInstance(true);
  }

  static AudioManager create(BuildContext context) {
    instance ??= AudioManager(context);
    return instance!;
  }

  Future stop() async {
    await _tts!.stop();
  }

  Future pause() async {
    await _tts!.pause();
  }

  speakText(String text) async {
    if (_tts != null) {
      const isEnabled = 'true';
      if (isEnabled == 'true') {
        if (text.contains('.')) {
          text = text.replaceAll('.', 'Point ');
        }
        await _tts!.speak(text);
      }
    }
  }
}
