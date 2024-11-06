import 'package:flutter/material.dart';
import 'package:flutter_todo/todo_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoHomeScreen(),
    );
  }
}

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({
    super.key,
  });

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  late final TextEditingController todoTitleController;
  late final TextEditingController todoDescriptionController;

  @override
  void initState() {
    todoTitleController = TextEditingController();
    todoDescriptionController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    todoTitleController.dispose();
    todoDescriptionController.dispose();
    super.dispose();
  }

  List<TodoModel> myTodoList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0,
          leading: const Icon(
            Icons.notes_outlined,
            color: Colors.black87,
            size: 20,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                myTodoList.clear();
                setState(() {});
              },
              child: const Icon(
                Icons.clear_all_rounded,
                size: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          title: const Text(
            "Flutter Todo",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
            ),
          ),
          elevation: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: todoTitleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[50],
                  label: const Text(
                    "Task",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: todoDescriptionController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[50],
                  label: const Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.deepPurple[300],
                onPressed: () {
                  final todoTitle = todoTitleController.text;
                  final todoDescription = todoDescriptionController.text;
                  final todoModel = TodoModel(
                    title: todoTitle,
                    decription: todoDescription,
                  );
                  myTodoList.add(todoModel);

                  todoTitleController.clear();
                  todoDescriptionController.clear();

                  FocusScope.of(context).unfocus();

                  setState(() {});
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My Todo List",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey[100],
                thickness: 1,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final todo = myTodoList[index];

                    return ListTile(
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (value) {
                          final completedTodo = TodoModel(
                            title: todo.title,
                            decription: todo.decription,
                            isCompleted: value ?? false,
                          );
                          myTodoList[index] = completedTodo;
                          setState(() {});
                        },
                      ),
                      tileColor: Colors.grey[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      subtitle: Text(
                        todo.decription,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            myTodoList.removeAt(index);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                            size: 18,
                          )),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: myTodoList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
