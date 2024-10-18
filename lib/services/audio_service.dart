import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

import '../theme/sounds.dart';
import 'logger_service.dart';

class AudioService implements Disposable {
  final LoggerService logger;

  AudioService({
    required this.logger,
  });

  ///
  /// VARIABLES
  ///

  late final AudioPlayer audioPlayer;

  ///
  /// INIT
  ///

  void init() => audioPlayer = AudioPlayer()..setAsset(RacunkoSounds.boom, preload: false);

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() => audioPlayer.dispose();

  ///
  /// METHODS
  ///

  void playAudio() => audioPlayer
    ..load()
    ..play();
}
