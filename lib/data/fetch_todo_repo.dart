import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/model/todo_model.dart';

class FetchTodoRepo {
  FetchTodoRepo();

  Box<List<TodoModel>> todoBox = Hive.box<List<TodoModel>>('todo');

  Future<Box<List<TodoModel>>> fetchTodoFromHive() async {
    return todoBox;
  }

  Future addTodoDataToHive(TodoModel todoModel, List<TodoModel> todo) async {
    if (!todoBox.containsKey(todoModel.id)) {

    todo.add(todoModel);

    await todoBox.put(todoModel.email, todo);
    }
  }

  Future<void> removeTodoFromHive(TodoModel todoModel) async {
    List<TodoModel> currentTodos = todoBox.get(todoModel.email) ?? [];
    currentTodos.removeWhere((element) => element.id == todoModel.id);
    await todoBox.put(todoModel.email, currentTodos);
  }
}
