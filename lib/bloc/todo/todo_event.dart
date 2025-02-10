part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class FetchTodoEvent extends TodoEvent {}

class FetchTodoDataInitialEvent extends TodoEvent {
  String email;

  FetchTodoDataInitialEvent({required this.email});
// final List<TodoModel> todoList;
// FetchTodoDataInitialEvent({required this.todoList});
}

class AddIconClickedEvent extends TodoEvent {}

class AddTodoButtonClickedEvent extends TodoEvent {
  TodoModel todoModel;

  AddTodoButtonClickedEvent({required this.todoModel});
}

class LogoutButtonClickedEvent extends TodoEvent {}

class CompletedIconClicked extends TodoEvent {
  TodoModel todoModel;

  CompletedIconClicked({required this.todoModel});
}

class UpdateTodoButtonClicked extends TodoEvent {
  TodoModel todoModel;
  int index;

  UpdateTodoButtonClicked({required this.todoModel, required this.index});
}

class EditTodoEvent extends TodoEvent {
  final int index;
  TodoModel todoModel;

  EditTodoEvent({required this.todoModel, required this.index});
}

class CheckButtonClickedEvent extends TodoEvent {
  TodoModel todoModel;

  CheckButtonClickedEvent({required this.todoModel});
}

class GreenCheckButtonClickedEvent extends TodoEvent {
  TodoModel todoModel;

  GreenCheckButtonClickedEvent({required this.todoModel});
}

class CrossButtonClickedEvent extends TodoEvent {}

class DeleteIconClickedEvent extends TodoEvent {
  TodoModel todoModel;

  DeleteIconClickedEvent({required this.todoModel});
}
