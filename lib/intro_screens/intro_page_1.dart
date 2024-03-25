import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class introPage1 extends StatelessWidget {
  const introPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/main.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Center(
            child: Lottie.asset('assets/tecno.json'),
          ),
         
          const Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Text(
              'Bienvenid@ a tu nueva experiencia',
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
