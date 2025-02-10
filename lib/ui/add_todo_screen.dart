import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo/todo_bloc.dart';
import 'package:to_do_app/constants/app_colors.dart';
import 'package:to_do_app/constants/app_images.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/ui/login_screen.dart';
import 'package:to_do_app/widgets/common_button.dart';
import 'package:to_do_app/widgets/common_widgets.dart';

class AddTodoScreen extends StatelessWidget {
  String email;

  AddTodoScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(FetchTodoDataInitialEvent(email: email));
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }

  _addTodoField(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        cursorColor: AppColors.appColor,
        controller: context.read<TodoBloc>().addTodoController,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.red)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            errorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        validator: (value) {
          if (value == null || value == "") {
            return 'Please Enter Todo';
          } else {
            return null;
          }
        },
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColors.appColor,
      title:
        Text(
          'Welcome ${email.split('@')[0].toString().toUpperCase()}',
          style: const TextStyle(
            color: Colors.white,
              fontSize: 17.0, fontWeight: FontWeight.w600),
        ),
      actions: [
        BlocListener<TodoBloc, TodoState>(
          listenWhen: (previous, current) => current is TodoActionState,
          listener: (context, state) {
            print("state ${state.runtimeType}");

            if (state is ShowDialogActionState) {
             _showDialog(context,state);
            } else if (state is PopDialogActionState) {
              Navigator.pop(context);
            }
            else if (state is LogoutActionState) {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen(),));
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(AddIconClickedEvent());
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 25.0,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(LogoutButtonClickedEvent());
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 25.0,
                    color: Colors.white,
                  )),
            ],
          ),
        )
      ],
    );
  }

  _body() {
    return BlocConsumer<TodoBloc, TodoState>(
        listenWhen: (previous, current) => current is TodoActionState,
        listener: (context, state) {
          if (state is ShowSnackBarActionState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message,),backgroundColor: AppColors.appColor,));
          }
        },
        buildWhen: (previous, current) => current is! TodoActionState,
        builder: (context, state) {
          print("state is ${state.runtimeType}");

          switch (state.runtimeType) {
            case FetchTodoInitialState ||
            TodoAddedSuccessfullyState ||
            TodoDeletedSuccessState ||
            TodoUpdatedSuccessfully ||
            CompletedSuccessState ||
            TodoInCompleteState:

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: imageAsset(
                          image: AppImages.todo,
                          height: MediaQuery.of(context).size.height * 0.27),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 1.0,
                                spreadRadius: 1.0)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: state.todoList.isNotEmpty
                          ? ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Container(
                // color: Colors.pink,
                            child: ListTile(
                              title: Text(
                                state.todoList[index].name.toString(),
                                style: textStyle.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        context.read<TodoBloc>().add(
                                            EditTodoEvent(
                                                todoModel:
                                                state.todoList[index],
                                                index: index));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 17.0,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<TodoBloc>()
                                            .add(DeleteIconClickedEvent(
                                          todoModel:
                                          state.todoList[index],
                                        ));
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 17.0,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        print(
                                            "paras ${state.todoList[index].isCompleted == false}");
                                        state.todoList[index]
                                            .isCompleted ==
                                            false
                                            ? context
                                            .read<TodoBloc>()
                                            .add(
                                            CheckButtonClickedEvent(
                                              todoModel: state
                                                  .todoList[index],
                                            ))
                                            : context.read<TodoBloc>().add(
                                            GreenCheckButtonClickedEvent(
                                                todoModel:
                                                state.todoList[
                                                index]));
                                      },
                                      icon: Icon(
                                        Icons.check_circle,
                                        size: 17.0,
                                        color: state.todoList[index]
                                            .isCompleted ==
                                            true
                                            ? AppColors.appColor
                                            : Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: 15),
                             child: Divider(
                              color: Colors.grey[300],
                              // height: 10,

                                                       ),
                           ),
                          itemCount: state.todoList.length ?? 0)
                          :  const Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            child: Text("No Todos found!")),
                      ),
                    ),
                  ],
                ),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        });
  }

  void _showDialog(BuildContext context,ShowDialogActionState state) {
      showDialog(
        context: context,
        builder: (_context) => AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.read<TodoBloc>().buttonText.toString(),
                style:  textStyle.copyWith(fontSize: 16.0,fontWeight: FontWeight.w600),
              ),
              IconButton(
                  onPressed: () {
                    context
                        .read<TodoBloc>()
                        .add(CrossButtonClickedEvent());
                  },
                  icon: const Icon(Icons.clear))
            ],
          ),
          content: Form(
            key: context.read<TodoBloc>().formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _addTodoField(context),
                const SizedBox(
                  height: 10,
                ),
                CommonButton(title: context.read<TodoBloc>().buttonText, onPress: () {
                  context.read<TodoBloc>().buttonText ==
                      "Add Todo"
                      ? context.read<TodoBloc>().add(
                      AddTodoButtonClickedEvent(
                          todoModel: TodoModel(
                              email: email,
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              name: context
                                  .read<TodoBloc>()
                                  .addTodoController
                                  .text,
                              isCompleted: false)))
                      : context.read<TodoBloc>().add(
                      UpdateTodoButtonClicked(
                          index: state.index,
                          todoModel: TodoModel(
                              email: email,
                              id: state.id,
                              name: context
                                  .read<TodoBloc>()
                                  .addTodoController
                                  .text,
                              isCompleted: false)));
                },),

              ],
            ),
          ), 
        ));
  }
}
