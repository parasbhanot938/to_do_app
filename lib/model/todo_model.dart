import 'package:hive/hive.dart';
import 'package:to_do_app/model/user_model.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool isCompleted;
  @HiveField(3)
  String email;



  TodoModel(
      {required this.id,
      required this.name,
      required this.isCompleted,
        required this.email
     });
}
