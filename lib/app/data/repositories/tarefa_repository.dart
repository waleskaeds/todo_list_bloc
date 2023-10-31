import 'package:todo_list/app/data/models/tarefa_model.dart';

class TarefaRepository {
  final List<TarefaModel> _tarefas = [];

  Future<List<TarefaModel>> getTarefas() async {
    _tarefas.addAll([
      TarefaModel(nome: 'Compras na farmácia'),
      TarefaModel(nome: 'Aula de inglês'),
      TarefaModel(nome: 'Exercícios físicos')
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