// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/todo_screen.dart';
import 'providers/todo_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoProvider>(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Aplikasi To-Do',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange, // Tema utama menggunakan warna hangat
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepOrange, // Konsisten dengan AppBar di TodoScreen
            foregroundColor: Colors.white,
            elevation: 4,
          ),
        ),
        home: const TodoScreen(),
      ),
    );
  }
}