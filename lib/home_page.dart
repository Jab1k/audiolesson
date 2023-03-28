import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_lesson/audio_player_page.dart';
import 'package:getx_lesson/home_controller.dart';

import 'first_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = Get.put(HomeController());
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    controller.getNames();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Getx Todo app"),
        leading: IconButton(onPressed: () {
          Get.to(()=> const AudioPlayerPage());
        },icon: const Icon(Icons.play_arrow),),
      ),
      body: Column(
        children: [
          GetBuilder<HomeController>(builder: (context) {
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.list.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: controller.list[index].status == 0
                                ? Colors.blueAccent
                                : controller.list[index].status == 1
                                    ? Colors.green
                                    : Colors.red),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: DropdownButton(
                                  value: controller.list[index].status,
                                  iconSize: 20,
                                  items: const [
                                    DropdownMenuItem(
                                      value: 0,
                                      child: Text(
                                        "New",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text("In Progress",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text("Ready",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ],
                                  onChanged: (selectStatus) {
                                    if (selectStatus != null) {
                                      controller.onChangeStatus(
                                          index, selectStatus);
                                    }
                                  }),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  controller.list[index].name,
                                  style: TextStyle(fontSize: 24),
                                ))
                          ],
                        ),
                      );
                    })
              ],
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Hello",
              content: TextFormField(
                controller: textEditingController,
                style: Get.textTheme.displayLarge,
              ),
              textCancel: "back",
              textConfirm: "Save",
              onConfirm: () {
                controller.addName(textEditingController.text);
                Get.back();
              });
          // controller.change();
        },
      ),
    );
  }
}
