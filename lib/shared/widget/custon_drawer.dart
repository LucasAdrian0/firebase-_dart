import 'package:flutter/material.dart';
import 'package:modulo8/pages/tarefas/tarefa_page.dart';

class CustonDrawer extends StatelessWidget {
  const CustonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //Tarefas
          ListTile(
            leading: Icon(Icons.task),
            title: Text("Tarefas"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TarefaPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
