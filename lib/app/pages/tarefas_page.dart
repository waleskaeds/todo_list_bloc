import 'package:flutter/material.dart';
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
    _tarefa.inputTarefa.add(GetTarefa());
  }

  @override
  void dispose() {
    super.dispose();
    _tarefa.inputTarefa.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      body: StreamBuilder<TarefaState>(
        stream: _tarefa.outputTarefa,
        builder: (context, state) {
          if(state.data is TarefaLoadingState){
            return const LinearProgressIndicator();
          }
          if(state.data is TarefaLoadedState){
            final list = state.data?.tarefas ?? [];
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(), 
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list[index].nome),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _tarefa.inputTarefa.add(
                          DeleteTarefa(tarefa: list[index]));
                    }, 
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
          _tarefa.inputTarefa.add(
              PostTarefa(tarefa: TarefaModel(nome: 'nome')));
        }
      ),
    );
  }
}