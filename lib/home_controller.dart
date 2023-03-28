import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_lesson/todo_model.dart';

class HomeController extends GetxController {
  final boxOfName = GetStorage();
  List<TodoModel> list = [];

  addName(String name) {
    List listJson = boxOfName.read("todos") ?? [];
    listJson.add(jsonEncode(TodoModel(name: name).toJson()));
    boxOfName.write("todos", listJson);
    getNames();
  }

  getNames() {
    list.clear();
    List listJson = boxOfName.read("todos") ?? [];
    for (var element in listJson) {
      list.add(
        TodoModel.fromJson(
          jsonDecode(element),
        ),
      );
    }
    update();
  }

  onChangeStatus(int selectItemIndex, int selectStatus) {
    list[selectItemIndex].status = selectStatus;
    update();
    List listJson = [];
    for (var element in list) {
      listJson.add(jsonEncode(element.toJson()));
    }
    boxOfName.write("todos", listJson);
  }
}
