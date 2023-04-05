import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'diaryFix.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Scene()));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(243, 222, 186, 1),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://media.discordapp.net/attachments/780253153173700648/1092751705524940850/logo.png'),
                radius: 50,
              ),
            ),
            Center(
              child: Lottie.network(
                  'https://assets10.lottiefiles.com/packages/lf20_pcfclxy8.json'),
            ),
          ],
        ),
      ),
    );
  }
}
