import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:todo_app/model/todo.dart';
import 'package:moor/moor.dart';

part 'database.g.dart';

@UseMoor(tables: [
  Todo
], queries: {
  '_getByType':
      'SELECT * FROM todo WHERE todo_type = ? order by is_done, date, time',
  '_completeTask': 'UPDATE todo SET is_done = 1 WHERE id = ?',
  '_deleteTask': 'DELETE FROM todo WHERE id = ?'
})
class Database extends _$Database with ChangeNotifier {
  // we tell the database where to store the data with this constructor
  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'todos_file.sqlite'));

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  Stream<List<TodoData>> getTodoByType(int type) => _getByType(type).watch();

  Future insertTodoEntries(TodoData entry) {
    return transaction(() async {
      await into(todo).insert(entry);
    });
  }

  Future completeTodoEntries(int id) {
    return transaction(() async {
      await _completeTask(id);
    });
  }

  Future deleteTodoEntries(int id) {
    return transaction(() async {
      await _deleteTask(id);
    });
  }
}
