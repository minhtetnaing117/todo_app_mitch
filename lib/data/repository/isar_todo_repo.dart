//  This implements the repo and handle storing, retrieving, updating, 
//  deleting in the isar database.


import 'package:isar/isar.dart';
import 'package:todo_app_mitch/data/models/isar_todo.dart';
import 'package:todo_app_mitch/domain/models/todo.dart';
import 'package:todo_app_mitch/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo{
  // database
  final Isar db;

  IsarTodoRepo(this.db);

  // get todos
  Future<List<Todo>> getTodos() async {
    // fetch from db
    final todos = await db.todoIsars.where().findAll();

    // return as a list of todos and give to domain layer
    return todos.map((todoIsars) => todoIsars.toDomain()).toList();
  }

  // add todo
  @override
  Future<void> addTodo(Todo newTodo) {
    // convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(newTodo);

    // so that we can store it in our isar db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  // update todo
  @override
  Future<void> updateTodo(Todo todo) {
     // convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(todo);

    // so that we can store it in our isar db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  // delete todo
  @override
  Future<void> deleteTodo(Todo todo) async{
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }
}