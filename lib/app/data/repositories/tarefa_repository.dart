import 'package:todo_list/app/data/models/tarefa_model.dart';

class TarefaRepository {
  final List<TarefaModel> _tarefas = [];

  Future<List<TarefaModel>> getTarefas() async {
    _tarefas.addAll([
      TarefaModel(nome: 'Compras'),
      TarefaModel(nome: 'Aula'),
      TarefaModel(nome: 'Exercícios')
    ]);
    return Future.delayed(
      const Duration(seconds: 2),
      () => _tarefas
    );
  }

  Future<List<TarefaModel>> postTarefa({required TarefaModel tarefa}) async {
    _tarefas.add(tarefa);

    return Future.delayed(
      const Duration(seconds: 2),
      () => _tarefas,
    );
  }

  Future<List<TarefaModel>> deleteTarefa({required TarefaModel tarefa}) async {
    _tarefas.remove(tarefa);

    return Future.delayed(
      const Duration(seconds: 2),
      () => _tarefas
    );
  }
}