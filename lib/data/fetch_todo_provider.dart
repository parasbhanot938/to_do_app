import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/fetch_todo_repo.dart';
import 'package:to_do_app/model/todo_model.dart';

class FetchTodoProvider {
  final FetchTodoRepo fetchTodoRepo;

  FetchTodoProvider({required this.fetchTodoRepo}) {
    fetchTodoData();
  }

  List<TodoModel> todoList = [];

  Future<Box<List<TodoModel>>> fetchTodoData() async {
    Box<List<TodoModel>> data = await fetchTodoRepo.fetchTodoFromHive();

    return data;
  }

  Future addTodoData(TodoModel todoModel, List<TodoModel> todo) async {
    await fetchTodoRepo.addTodoDataToHive(todoModel, todo);
  }

  deleteTodoData(TodoModel todoModel) {
    fetchTodoRepo.removeTodoFromHive(todoModel);
  }
}
