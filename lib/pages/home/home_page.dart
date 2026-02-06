import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:modulo8/shared/widget/custon_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var nicknameController = TextEditingController();
    final remoteConfig = FirebaseRemoteConfig.instance;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(
          int.parse("0xff" + remoteConfig.getString("COR_FUNDO_TELA")),
        ),
        drawer: CustonDrawer(),
        appBar: AppBar(title: Text("Home")),
      ),
    );
  }
}
