import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:musik_daerah/controller/musik_controller.dart';
import 'package:musik_daerah/custom_slider.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicPlayerController mpc = Get.put(MusicPlayerController());

    return Scaffold(
      body: Center(
        child: Obx(() => Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      color: Colors.black
                    ),
                    width: Get.width,
                    padding: const EdgeInsets.all(10).copyWith(left: 110),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mpc.musicList[mpc.selectedMusic.value]["title"],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                          ),
                        ),
                        Text(
                          mpc.musicList[mpc.selectedMusic.value]["author"],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 12
                          ),
                        ),
                        Obx(() => SliderTheme(
                          data: const SliderThemeData(
                            trackShape: CustomSliderTrackShape(),
                            thumbShape: CustomSliderThumbShape(),
                            overlayShape: CustomSliderOverlayShape(),
                          ),
                          child: Slider(
                            value: mpc.musicDuration.value,
                            min: 0,
                            max: mpc.totalDuration.value,
                            onChanged: (newVal) {
                              mpc.seekMusic(newVal);
                            },
                          ),
                        )),
                        Obx(() => Row(
                          children: [
                            Text(
                              mpc.musicDurationStringFormat(mpc.musicDuration.value),
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12
                              ),
                            ),
                            Text(
                              " : ${mpc.musicDurationStringFormat(mpc.totalDuration.value)}",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.8)
                    ),
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.backward),
                            color: Colors.white,
                            onPressed: () {
                              mpc.previousMusic();
                            },
                          ),
                          Obx(() => IconButton(
                            icon: FaIcon(mpc.isPlaying.isTrue ?
                             FontAwesomeIcons.pause : FontAwesomeIcons.play),
                            color: Colors.white,
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.green
                            ),
                            onPressed: () {
                              if (mpc.isPlaying.isTrue) {
                                mpc.pauseMusic();
                              } else {
                                mpc.playMusic();
                              }
                            },
                          )),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.forward),
                            color: Colors.white,
                            onPressed: () {
                              mpc.nextMusic();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 25,
              width: 115,
              height: 115,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Obx(() => AnimatedRotation(
                      duration: const Duration(seconds: 1),
                      turns: mpc.musicDuration.value / 20000,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(mpc.musicList[mpc.selectedMusic.value]["image"]),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}