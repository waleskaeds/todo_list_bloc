import 'package:flutter/material.dart';
import 'package:todo_list/app/pages/tarefas_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const TarefasPage(),
    );
  }
}
