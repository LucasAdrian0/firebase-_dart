import 'package:cloud_firestore/cloud_firestore.dart';

class TarefaModel {
  String descricao = "";
  bool concluido = false;
  DateTime dataCriacao = DateTime.now();
  DateTime dataAlteracao = DateTime.now();
  String userId = "";
   

  TarefaModel({required String userId, required this.descricao, required this.concluido,});

  TarefaModel.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    concluido = json['concluido'];
    dataCriacao = (json['data_criacao'] as Timestamp).toDate();
    dataAlteracao = (json['data_alteracao']as Timestamp).toDate();
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['concluido'] = this.concluido;
    data['data criacao'] = Timestamp.fromDate(this.dataCriacao);
    data['data alteravao'] = this.dataAlteracao;
    data['user id'] = this.userId;
    return data;
  }
}
