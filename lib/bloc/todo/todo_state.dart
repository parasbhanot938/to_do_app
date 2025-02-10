part of 'todo_bloc.dart';

@immutable
abstract class TodoState {
   List<TodoModel> todoList=[];

}
abstract class TodoActionState extends TodoState {}
class LogoutActionState extends TodoActionState {}

class TodoInitial extends TodoState {}
class FetchTodoInitialState extends TodoState{
  final List<TodoModel> todoList;
  FetchTodoInitialState({required this.todoList});
}
class ShowDialogActionState extends TodoActionState{
  int index;
  String id;
  ShowDialogActionState({required this.index,required this.id});

}

class PopDialogActionState extends TodoActionState{

}
class EditTodoActionState extends TodoActionState{
final TodoModel todoModel;
EditTodoActionState({required this.todoModel});
}


class TodoAddedSuccessfullyState extends TodoState{
  final List<TodoModel> todoList;
  TodoAddedSuccessfullyState({required this.todoList});

}
class TodoUpdatedSuccessfully extends TodoState{
  final List<TodoModel> todoList;

  TodoUpdatedSuccessfully({required this.todoList});

}
class TodoCompletedState extends TodoState{
  final List<TodoModel> todoList;

  TodoCompletedState({required this.todoList});

}


class ShowSnackBarActionState extends TodoActionState{
  String message;
  ShowSnackBarActionState({required this.message});

}
class TodoInCompleteState extends TodoState{
  final List<TodoModel> todoList;

  TodoInCompleteState({required this.todoList});

}


class TodoDeletedSuccessState extends TodoState{

  final List<TodoModel> todoList;
  TodoDeletedSuccessState({required this.todoList});

}



class CompletedSuccessState extends TodoState{

  final List<TodoModel> todoList;
  CompletedSuccessState({required this.todoList});

}
