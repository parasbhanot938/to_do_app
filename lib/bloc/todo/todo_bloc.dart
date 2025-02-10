import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/data/auth_provider.dart';
import 'package:to_do_app/data/fetch_todo_provider.dart';
import 'package:to_do_app/model/todo_model.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  var addTodoController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var todoNode = FocusNode();

  String buttonText = 'Add Todo';

  String selectedTodoId = '';

  TodoBloc(this.fetchTodoProvider,this.authRepoProvider) : super(TodoInitial()) {
    on<FetchTodoDataInitialEvent>(fetchTodoDataInitialEvent);

    on<AddIconClickedEvent>(addIconClickedEvent);
    on<AddTodoButtonClickedEvent>(addTodoButtonClickedEvent);
    on<EditTodoEvent>(editTodoEvent);
    on<CrossButtonClickedEvent>(crossButtonClickedEvent);
    on<DeleteIconClickedEvent>(deleteIconClickedEvent);
    on<UpdateTodoButtonClicked>(updateTodoButtonClicked);
    on<CompletedIconClicked>(completedIconClicked);
    on<CheckButtonClickedEvent>(checkButtonClickedEvent);
    on<GreenCheckButtonClickedEvent>(greenCheckButtonClickedEvent);
    on<LogoutButtonClickedEvent>(logoutButtonClickedEvent);
  }

  FetchTodoProvider fetchTodoProvider;
  AuthRepoProvider authRepoProvider;
  List<TodoModel> todo = [];

  FutureOr<void> addIconClickedEvent(
      AddIconClickedEvent event, Emitter<TodoState> emit) {
    addTodoController.clear();
    buttonText = 'Add Todo';
    emit(ShowDialogActionState(index: 0, id: ''));
    // emit(TodoInitial());
  }

  Future<void> addTodoButtonClickedEvent(
      AddTodoButtonClickedEvent event, Emitter<TodoState> emit) async {
    if (formKey.currentState!.validate()) {
      Box<List<TodoModel>> data = await fetchTodoProvider.fetchTodoData();

      fetchTodoProvider.addTodoData(event.todoModel, todo);

      todo = (data.get(event.todoModel.email)) ?? [];
      emit(TodoAddedSuccessfullyState(todoList: todo));
      emit(PopDialogActionState());
      emit(ShowSnackBarActionState(message: "Todo Added Successfully!"));

      addTodoController.clear();
    }
  }

  Future<void> fetchTodoDataInitialEvent(
      FetchTodoDataInitialEvent event, Emitter<TodoState> emit) async {
    Box<List<TodoModel>> data = await fetchTodoProvider.fetchTodoData();

    todo = (data.get(event.email)) ?? [];
    emit(FetchTodoInitialState(todoList: todo));
  }

  FutureOr<void> editTodoEvent(EditTodoEvent event, Emitter<TodoState> emit) {
    // fetchTodoProvider.addTodoData(event.todoModel);

    addTodoController.text = event.todoModel.name;
    buttonText = 'Update Todo';
    selectedTodoId = event.todoModel.id;
    emit(ShowDialogActionState(index: event.index, id: selectedTodoId));
    // emit(ShowSnackBarActionState(message: "Todo Updated Successfully!"));
  }

  FutureOr<void> crossButtonClickedEvent(
      CrossButtonClickedEvent event, Emitter<TodoState> emit) {
    emit(PopDialogActionState());
  }

  Future<void> deleteIconClickedEvent(
      DeleteIconClickedEvent event, Emitter<TodoState> emit) async {
    await fetchTodoProvider.deleteTodoData(event.todoModel);
    Box<List<TodoModel>> data = await fetchTodoProvider.fetchTodoData();
    List<TodoModel> updatedTodos =
        (data.get(event.todoModel.email ?? '')) ?? [];

    emit(TodoDeletedSuccessState(todoList: updatedTodos));
    emit(ShowSnackBarActionState(message: "Todo Deleted Successfully!"));
  }

  Future<void> updateTodoButtonClicked(
      UpdateTodoButtonClicked event, Emitter<TodoState> emit) async {
    if (formKey.currentState!.validate()) {
      event.todoModel.name = addTodoController.text;

      Box<List<TodoModel>> data = await fetchTodoProvider.fetchTodoData();

      List<TodoModel> currentTodos = data.get(event.todoModel.email) ?? [];
      debugPrint("cuurrrent todos ${currentTodos.map(
        (e) => e.id,
      )}");
      debugPrint("currewnt index id ${event.todoModel.id}");

      int index1 =
          currentTodos.indexWhere((todo) => todo.id == event.todoModel.id);
      debugPrint("index ${index1}");
      if (index1 != -1) {
        currentTodos[index1] = event.todoModel;
        await data.put(event.todoModel.email, currentTodos);

        emit(TodoUpdatedSuccessfully(todoList: currentTodos));
        emit(PopDialogActionState());
        emit(ShowSnackBarActionState(message: "Todo Updated Successfully!"));
      }
    }
  }

  FutureOr<void> completedIconClicked(
      CompletedIconClicked event, Emitter<TodoState> emit) {}

  Future<void> checkButtonClickedEvent(
      CheckButtonClickedEvent event, Emitter<TodoState> emit) async {
    event.todoModel.isCompleted = true;

    Box<List<TodoModel>> data = await fetchTodoProvider.fetchTodoData();

    List<TodoModel> currentTodos = data.get(event.todoModel.email) ?? [];
    debugPrint("current todos ${currentTodos.map(
      (e) => e.id,
    )}");
    debugPrint("current index id ${event.todoModel.id}");

    int index1 =
        currentTodos.indexWhere((todo) => todo.id == event.todoModel.id);
    debugPrint("index ${index1}");

    if (index1 != -1) {
      currentTodos[index1] = event.todoModel;
      await data.put(event.todoModel.email, currentTodos);
      emit(CompletedSuccessState(todoList: todo));
    }
  }

  Future<void> greenCheckButtonClickedEvent(
      GreenCheckButtonClickedEvent event, Emitter<TodoState> emit) async {
    debugPrint("eventof green ${event}");
    event.todoModel.isCompleted = false;

    Box<List<TodoModel>> data = await fetchTodoProvider.fetchTodoData();

    List<TodoModel> currentTodos = data.get(event.todoModel.email) ?? [];
    debugPrint("current todos ${currentTodos.map(
      (e) => e.id,
    )}");
    debugPrint("current index id ${event.todoModel.id}");

    int index1 =
        currentTodos.indexWhere((todo) => todo.id == event.todoModel.id);
    debugPrint("index ${index1}");

    if (index1 != -1) {
      currentTodos[index1] = event.todoModel;
      await data.put(event.todoModel.email, currentTodos);
      emit(TodoInCompleteState(todoList: todo));
    }
  }

  FutureOr<void> logoutButtonClickedEvent(
      LogoutButtonClickedEvent event, Emitter<TodoState> emit) {
    // authRepoProvider.clearSecureStorage();
    emit(LogoutActionState());
  }
}
