import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _bookmarked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleBookmark() {
    setState(() {
      _bookmarked = !_bookmarked;
      if (_bookmarked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _toggleBookmark,
          child: Lottie.network(
            'https://lottie.host/42bcf827-0ad4-4140-8d4b-cb4c7f17cbec/MsBQcuax1l.json', // Reemplaza 'link' con tu URL de Lottie.
            controller: _controller,
            onLoaded: (composition) {
              // Asegúrate de que la animación esté pausada al principio.
             // _controller.pause();
            },
          ),
        ),
      ),
    );
  }
}
