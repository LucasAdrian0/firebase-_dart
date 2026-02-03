import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modulo8/models/tarefa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class TarefaPage extends StatefulWidget {
  TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  final db = FirebaseFirestore.instance;
  String userId = "";

  var descricaoController = TextEditingController();

  var apenasNaoConcluidos = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarUsuario();
  }

  carregarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    var uuid = Uuid();
    userId = prefs.getString('user_id') ?? uuid.v4();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Tarefas")),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            descricaoController.text = "";
            showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Adicionar tarefa"),
                  content: TextField(controller: descricaoController),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () async {
                        var tarefa = TarefaModel(
                          descricao: descricaoController.text,
                          concluido: false,
                          userId : userId
                          
                        );
                        await db.collection("tarefas").add(tarefa.toJson());
                        Navigator.pop(context);
                      },
                      child: Text("Salvar"),
                    ),
                  ],
                );
              },
            );
          },
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text("Tarefa Firebase", style: TextStyle(fontSize: 26)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Apenas não concluidos",
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                      value: apenasNaoConcluidos,
                      onChanged: (bool value) {
                        apenasNaoConcluidos = value;
                        setState(() {});
                      },
                    ),
                    Builder(
                      builder: (_) {
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: apenasNaoConcluidos
                      ? db
                            .collection("tarefas")
                            .where('concluido', isEqualTo: false)
                            .snapshots()
                      : db.collection("tarefas").snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? CircularProgressIndicator()
                        : ListView(
                            children: snapshot.data!.docs.map((e) {
                              var tarefa = TarefaModel.fromJson(
                                (e.data() as Map<String, dynamic>),
                              );
                              return Dismissible(
                                onDismissed:
                                    (DismissDirection dismissDirection) async {
                                      await db
                                          .collection("tarefas")
                                          .doc(e.id)
                                          .delete();
                                    },
                                key: Key(e.id),
                                child: ListTile(
                                  title: Text(tarefa.descricao),
                                  trailing: Switch(
                                    onChanged: (bool value) async {
                                      tarefa.concluido = value;
                                      await db
                                          .collection("tarefas")
                                          .doc(e.id)
                                          .update(tarefa.toJson());
                                    },
                                    value: tarefa.concluido,
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
