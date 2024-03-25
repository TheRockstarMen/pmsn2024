import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class introPage3 extends StatelessWidget {
  const introPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de la imagen
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/sist2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Animación Lottie en el centro
          Center(
            child: Lottie.asset('assets/walk.json'),
          ),
          // Texto en la parte inferior
          const Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Text(
              'disfruta tus clases',
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
