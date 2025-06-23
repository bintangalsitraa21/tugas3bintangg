// lib/providers/todo_provider.dart
import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  // Menambahkan to-do baru
  void addTodo(String title) {
    // Menggunakan DateTime.now().toString() sebagai ID sederhana
    _todos.add(Todo(id: DateTime.now().toString(), title: title));
    notifyListeners(); // Beri tahu UI bahwa data telah berubah
  }

  // Mengubah status selesai/belum selesai to-do
  void toggleDone(String id) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      _todos[todoIndex].isDone = !_todos[todoIndex].isDone;
      notifyListeners();
    }
  }

  // Menghapus to-do
  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  // Memperbarui judul to-do
  void updateTodo(String id, String newTitle) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      _todos[todoIndex].title = newTitle;
      notifyListeners();
    }
  }
}