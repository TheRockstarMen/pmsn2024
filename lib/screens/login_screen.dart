import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pmsn2024/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  




  bool isLoading = false;

  //------------------------------------

final txtUser = TextFormField(
decoration: const InputDecoration(
icon: Icon(Icons.person),
label: Text('usuario: '),
border: OutlineInputBorder()),
validator: (value) {
if (value == null || value.isEmpty) {
return 'por favor coloca un usuario';
}
return null;
},
);


  //-------------------------------------

  //--------------------------

final txtEmail = TextFormField(
decoration: const InputDecoration(
icon: Icon(Icons.email),
label: Text('Email: '),
border: OutlineInputBorder()),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your email';
} else if (!EmailValidator.validate(value, true)) {
return 'por favor coloca un email valido';
} else {
return null;
}
},
);

  //---------------------------

 /* final txtUser = TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      border: OutlineInputBorder()
    ),
  );*/
//-----VALIDACION DE CONTRAS










  final pwdUser = TextFormField(
    keyboardType: TextInputType.text,
    obscureText: true,
    decoration: const InputDecoration(
      border: OutlineInputBorder()
    ),
  );

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage( 
            fit: BoxFit.cover,
            image: AssetImage('images/voiyd_1.PNG')
          )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 470,
              child: Opacity(
                opacity: .5,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  height: 155,
                  width: MediaQuery.of(context).size.width*.9,
                  child: ListView(
                      shrinkWrap: true,
                      children: [
                        txtUser,
                        txtEmail,
                        
                        
                        const SizedBox(height: 10,),
                        pwdUser
                        
                      ],
                    ),
                ),
              ),
            ),
            Image.asset('images/logo_text.png'),
            Positioned(
              bottom: 50,
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width*.9,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SignInButton(
                      Buttons.Email, 
                      onPressed: (){
                        setState(() {
                          isLoading = !isLoading;
                        });
                        Future.delayed(
                          const Duration(milliseconds: 5000),
                          (){
                            /*Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => new DashboardScreen(),)
                            );*/
                            Navigator.pushNamed(context, "/dash").then((value){
                              setState(() {
                                isLoading = !isLoading;
                              });
                            });
                          }
                        );
                      }
                    ),
                    SignInButton(
                      Buttons.Google, 
                      onPressed: (){}
                    ),
                    SignInButton(
                      Buttons.Facebook, 
                      onPressed: (){}
                    ),
                  
                  //tienes cuenta---------------

                  _register(context)


                  //------------------------



                  ],
                ),
              )
            ),
            isLoading ? const Positioned(
              top: 260,
              child: CircularProgressIndicator(
                color: Colors.white,
              )
            )
            : Container()
          ],
        ),
      ),
    );
  }
}

 _register(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Quieres una cuenta bro? "),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              );
            },
            child: const Text(
              "Unete dando click aqui!",
              style: TextStyle(color: Color.fromARGB(255, 110, 224, 114)),
            ))
      ],
    );
  }