import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:modulo8/pages/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SplashScreanPage extends StatefulWidget {
  const SplashScreanPage({super.key});

  @override
  State<SplashScreanPage> createState() => _SplashScreanPageState();
}

class _SplashScreanPageState extends State<SplashScreanPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarHome();
  }

  /*CarregarHome();
  Vai procurar o ID do usuário, se tiver ok, se não tiver id vai gerar um id novo e guardar
  Em seguida, aguarda 2 segundos e navega para HomePage();
  */
  carregarHome() async {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    await analytics.logEvent(name: "SplashScreenOpen");
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id');
    if (userId == null) {
      var uuid = const Uuid();
      userId = uuid.v4();
      await prefs.setString('user_id', userId);
    }
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
