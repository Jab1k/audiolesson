import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayerController extends GetxController {
  final player = AudioPlayer();
  bool isPlaying = false;
  bool isVolume = true;
  Duration? duration;

  getTime() async {
    await player.setUrl(
        'https://cdns-preview-f.dzcdn.net/stream/c-f4d04fa22ff3cc680cad30eea149cc1d-6.mp3');
    update();
  }


  playOrPause() {
    isPlaying ? player.pause() : player.play();
    isPlaying = !isPlaying;
    update();
  }

  setVolume() {
    isVolume ? player.setVolume(0) : player.setVolume(1);
    isVolume = !isVolume;
    update();
  }

  setSpeed(double speed) {
    player.setSpeed(speed);
  }
}
