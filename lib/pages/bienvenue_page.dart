import 'package:flutter/material.dart';
import 'package:djiguiba_music/component/bottom_pied_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(); // Permet à l'animation de se répéter

    Future.delayed(
      const Duration(seconds: 5),
      () {
        _controller
            .stop(); // Arrêtez l'animation avant de naviguer vers la page suivante
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomPiedPage()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 16),
            Text(
              'MusicDji vous souhaite la bienvenue !!!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Container(
              // width: 30,
              // height: 30,
              child: CircularProgressIndicator(
                valueColor: _controller.drive(
                  ColorTween(
                    begin:
                        Color.fromARGB(255, 28, 180, 20), // Couleur de départ
                    end: Color.fromARGB(255, 28, 180, 20), // Couleur de fin
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
