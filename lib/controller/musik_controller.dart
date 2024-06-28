import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MusicPlayerController extends GetxController {
  late final FlutterSoundPlayer player;

  StreamSubscription? playerSubs;

  RxInt selectedMusic = RxInt(0);
  RxDouble musicDuration = RxDouble(0);
  RxDouble totalDuration = RxDouble(0);
  RxBool isPlaying = RxBool(false);

  List<Map<String, dynamic>> musicList = [
    {
      "sound": "assets/sounds/NCS.mp3",
      "image": "assets/nature-1.jpg",
      "title": "On & On (feat. Daniel Levi)",
      "author": "Cartoon, Jéja"
    },
    {
      "sound": "assets/sounds/Himitsu.mp3",
      "image": "assets/nature-2.jpg",
      "title": "Adventures",
      "author": "A Himitsu"
    },
  ];

  @override
  void onInit() {
    super.onInit();

    player = FlutterSoundPlayer();
    player.openPlayer().then((_) async {
      await player.setSubscriptionDuration(const Duration(milliseconds: 50));
      playerSubs = player.onProgress!.listen((e) {
        totalDuration.value = e.duration.inMilliseconds.toDouble();
        musicDuration.value = e.position.inMilliseconds.toDouble();
      });
    });
  }

  @override
  void onClose() {
    player.stopPlayer();

    playerSubs?.cancel();
    playerSubs = null;

    player.closePlayer();

    super.onClose();
  }

  String musicDurationStringFormat(double milliseconds) {
    int seconds = milliseconds ~/ 1000;
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  Future playMusic() async {
    final musicData = await getAssetData(musicList[selectedMusic.value]["sound"]);
    await player.startPlayer(
        fromDataBuffer: musicData,
        codec: Codec.mp3,
        whenFinished: () {
          isPlaying.value = false;
          nextMusic();
        }
    );
    isPlaying.value = true;
  }

  Future pauseMusic() async {
    await player.pausePlayer();
    isPlaying.value = false;
  }

  Future nextMusic() async {
    selectedMusic.value++;
    await playMusic();
  }

  Future previousMusic() async {
    selectedMusic.value--;
    await playMusic();
  }

  Future<Uint8List> getAssetData(String path) async {
    var asset = await rootBundle.load(path);
    return asset.buffer.asUint8List();
  }

  Future seekMusic(double newVal) async {
    musicDuration.value = newVal;
    await player.seekToPlayer(Duration(milliseconds: newVal.floor()));
  }
}