import 'package:flutter/material.dart';
import 'package:modulo8/shared/widget/custon_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustonDrawer(),
        appBar: AppBar(title: Text("Home")),
        body: Container(),
      ),
    );
  }
}
