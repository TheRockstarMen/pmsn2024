import 'dart:io';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmsn2024/screens/onboarding_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _image;

  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  final spaceHorizontal = const SizedBox(height: 10);

  //---funcion pick image--------------
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  //-------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.5,
                fit: BoxFit.cover,
                image: AssetImage('images/voiyd_2.PNG'),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        spaceHorizontal,
                        spaceHorizontal,
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Seleccionar imagen'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: const Text('Galería'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _pickImage(ImageSource.gallery);
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        GestureDetector(
                                          child: const Text('Cámara'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _pickImage(ImageSource.camera);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            child:
                                _image == null ? const Icon(Icons.camera_alt) : null,
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: 'Nombre: ',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu nombre';
                            }
                            return null;
                          },
                        ),
                        spaceHorizontal,
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: 'Apellido: ',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu apellido';
                            }
                            return null;
                          },
                        ),
                        spaceHorizontal,
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: 'Email: ',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu correo electrónico';
                            } else if (!EmailValidator.validate(value, true)) {
                              return 'Correo electrónico inválido, por favor ingresa un correo válido';
                            }
                            return null;
                          },
                        ),
                        spaceHorizontal,
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.password),
                            labelText: 'Contraseña: ',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa una contraseña';
                            } else if (!validateStructure(value)) {
                              return 'Por favor, ingresa una contraseña válida';
                            }
                            return null;
                          },
                        ),
                        spaceHorizontal,
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Procesando datos')),
                              );
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnBoardingScreen(),
                              ),
                            );
                          },
                          child: const Text('Registrarse'),
                        ),
                        spaceHorizontal,
                        const Text('o'),
                        spaceHorizontal,
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Registrarse con Google'),
                        ),
                        spaceHorizontal,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
