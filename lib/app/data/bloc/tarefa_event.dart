import 'package:todo_list/app/data/models/tarefa_model.dart';

abstract class TarefaEvent {}

class GetTarefa extends TarefaEvent {}

class PostTarefa extends TarefaEvent {
  final TarefaModel tarefa;

  PostTarefa({required this.tarefa});
}

class DeleteTarefa extends TarefaEvent {
  final TarefaModel tarefa;

  DeleteTarefa({required this.tarefa});
}
