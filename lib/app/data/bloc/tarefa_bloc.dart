import 'dart:async';

import 'package:todo_list/app/data/bloc/tarefa_event.dart';
import 'package:todo_list/app/data/bloc/tarefa_state.dart';
import 'package:todo_list/app/data/models/tarefa_model.dart';
import 'package:todo_list/app/data/repositories/tarefa_repository.dart';

class TarefaBloc {
  final _repository = TarefaRepository();

  final _inputTarefaController = StreamController<TarefaEvent>();
  final _outputTarefaController = StreamController<TarefaState>();

  Sink<TarefaEvent> get inputTarefa => _inputTarefaController.sink;
  Stream<TarefaState> get outputTarefa => _outputTarefaController.stream;

  TarefaBloc(){
    _inputTarefaController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TarefaEvent event) async {
    List<TarefaModel> tarefas = [];

    _outputTarefaController.add(TarefaLoadingState());

    if(event is GetTarefa) {
      tarefas = await _repository.getTarefas();
    } else if(event is PostTarefa){
      tarefas = await _repository.postTarefa(tarefa: event.tarefa);
    } else if(event is DeleteTarefa) {
      tarefas = await _repository.deleteTarefa(tarefa: event.tarefa);
    }

    _outputTarefaController.add(TarefaLoadedState(tarefas: tarefas));
  }
}