import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class introPage2 extends StatelessWidget {
  const introPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de la imagen
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/sistemasBuild.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Animación Lottie en el centro
          Center(
            child: Lottie.asset('assets/cubes.json'),
          ),
          // Texto en la parte inferior
          const Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Text(
              'podras dar rienda suelta a tu conocimiento',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
