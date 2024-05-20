// import 'package:flutter_oatto/model/todomodel.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:uuid/uuid.dart';

// class TodoNotifier extends StateNotifier<List<Todo>> {
//   TodoNotifier() : super([]);

//   void create(Todo todo) {
//     todo.uuid = const Uuid().v4();
//     todo.createdAt = DateTime.now().toIso8601String();
//     state = [...state, todo];
//   }

//   void removeTodo(String todoId) {
//     state = state.where((item) => item.uuid != todoId).toList();
//   }
// }

// final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
//   (ref) {
//     return TodoNotifier();
//   },
// );


