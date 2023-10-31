import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/app/data/bloc/tarefa_bloc.dart';
import 'package:todo_list/app/data/bloc/tarefa_event.dart';
import 'package:todo_list/app/data/bloc/tarefa_state.dart';
import 'package:todo_list/app/data/models/tarefa_model.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  late final TarefaBloc _tarefa;

  @override
  void initState() {
    super.initState();
    _tarefa = TarefaBloc();
    _tarefa.add(GetTarefa());
  }

  @override
  void dispose() {
    super.dispose();
    _tarefa.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      body: BlocBuilder<TarefaBloc, TarefaState>(
        bloc: _tarefa,
        builder: (context, state) {
          if(state is TarefaLoadingState){
            return const LinearProgressIndicator();
          }
          if(state is TarefaLoadedState){
            final list = state.tarefas;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(list[index].nome),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _tarefa.add(
                            DeleteTarefa(tarefa: list[index]));
                      }, 
                    ),
                  ),
                );
              }, 
            );
          }
          return const Center(child: Text('Erro'));
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          _tarefa.add(
              PostTarefa(tarefa: TarefaModel(nome: 'Arrumar a casa')));
        }
      ),
    );
  }
}