// lib/screens/todo_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _todoController = TextEditingController();

  void _addTodo() {
    if (_todoController.text.isNotEmpty) {
      Provider.of<TodoProvider>(context, listen: false).addTodo(_todoController.text);
      _todoController.clear();
    }
  }


  void _showEditTodoDialog(BuildContext context, Todo todo) {
    final TextEditingController editController = TextEditingController(text: todo.title);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Edit To-Do',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              hintText: 'Masukkan judul baru',
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber[700]!, width: 2.0), 
              ),
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal', style: TextStyle(color: Colors.redAccent)), 
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700], 
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
              onPressed: () {
                if (editController.text.isNotEmpty) {
                  Provider.of<TodoProvider>(context, listen: false)
                      .updateTodo(todo.id, editController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Kegiatan Saya',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange, 
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      labelText: 'Kegiatan Baru',
                      hintText: 'Apa yang perlu Anda lakukan?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(Icons.note_add, color: Colors.deepOrange), 
                      filled: true,
                      fillColor: Colors.orange[50], 
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTodo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange, 
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Tambah',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                if (todoProvider.todos.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 100,
                          color: Colors.brown[300], 
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Belum ada kegiatan yang tersedia!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.brown[400], 
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: todoProvider.todos.length,
                  itemBuilder: (context, index) {
                    final todo = todoProvider.todos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: todo.isDone ? Colors.orange[100] : Colors.white, 
                      child: ListTile(
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (bool? newValue) {
                            todoProvider.toggleDone(todo.id);
                          },
                          activeColor: Colors.deepOrange, 
                          checkColor: Colors.white,
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: todo.isDone ? Colors.brown[600] : Colors.black87, 
                            fontSize: 18,
                            fontWeight: todo.isDone ? FontWeight.normal : FontWeight.w500,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.amber), 
                              onPressed: () => _showEditTodoDialog(context, todo),
                              tooltip: 'Edit To-Do',
                            ),
                            // <<< AKHIR FITUR EDIT
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent), 
                              onPressed: () {
                                todoProvider.deleteTodo(todo.id);
                              },
                              tooltip: 'Hapus To-Do',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Fungsi opsional, misalnya bisa membuka bottom sheet untuk tambah to-do
        },
        label: const Text('Tambah Cepat', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.orange, // Warna hangat FAB
        elevation: 6,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}