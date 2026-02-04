import 'package:flutter/material.dart';
import 'package:modulo8/pages/chat/chat_page.dart';
import 'package:modulo8/shared/widget/custon_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var nicknameController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        drawer: CustonDrawer(),
        appBar: AppBar(title: Text("Home")),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Informe seu apelido"),
              TextField(controller: nicknameController),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ChatPage(nickName: nicknameController.text),
                    ),
                  );
                },
                child: Text("Entrar no Chat"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
