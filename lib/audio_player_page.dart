import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_lesson/audio_player_controller.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({Key? key}) : super(key: key);

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  final controller = Get.put(PlayerController());

  @override
  void initState() {
    controller.getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Text(
              "Perfect",
              style: TextStyle(color: Colors.black),
            ),
            GetBuilder<PlayerController>(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.setVolume();
                    },
                    icon: Icon(controller.isVolume
                        ? Icons.volume_up
                        : Icons.volume_off),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.playOrPause();
                    },
                    icon: Icon(
                        controller.isPlaying ? Icons.pause : Icons.play_arrow),
                    iconSize: 32,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.speed),
                      ),
                      DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            value: 1.0,
                            child: Text(
                              "1x",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2.0,
                            child: Text("2x",
                                style: TextStyle(color: Colors.black)),
                          ),
                          DropdownMenuItem(
                            value: 3.0,
                            child: Text("3x",
                                style: TextStyle(color: Colors.black)),
                          )
                        ],
                        onChanged: (s) {
                          if (s != null) {
                            controller.setSpeed(s);
                          }
                        },
                        value: controller.player.speed,
                      )
                    ],
                  ),
                ],
              );
            }),
            StreamBuilder(
                stream: controller.player.positionStream,
                builder: (context, s) {
                  return Column(
                    children: [
                      Text(
                        s.data.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                      Slider(
                          value: (s.data?.inSeconds ?? 1) /
                              (controller.player.duration?.inSeconds ?? 1),
                          onChanged: (value) {
                            print("value ; $value");
                            print(value *
                                (controller.player.duration?.inSeconds ?? 1));
                          })
                    ],
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
