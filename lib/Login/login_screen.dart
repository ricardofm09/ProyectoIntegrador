import 'package:flutter/material.dart';
import 'package:greenflow/services/auth/auth.dart';
import '../Home/home_screen.dart';
import '../Registro/register_screen.dart';
import 'package:greenflow/utils/my_dialog_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isDoingRequest = false;

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    bool isLogin = await _authService.login(email, password);

    if (isLogin) {
      //print('logueo exitoso.');
      _isDoingRequest = false;

      _navigateToHome();
      setState(() {});
    } else {
      //print('error en el loguio');
      _isDoingRequest = false;
      showDialogAlert(
          title: "Aviso!",

          content: const Text(
            'Error en el login',
            style: TextStyle(color: Colors.white, fontSize: 15.0), // Cambia el color y tamaño del texto aquí
          ),
          showActions: true);

      setState(() {});
    }
  }

  void showDialogAlert(
      {required String title,
        required Widget content,
        required bool showActions}) {
    MyDialogAlert.showAlertDialogContent(
      context: context,
      title: title,
      content: SizedBox(
        width: 200.0, // Añade la anchura del diálogo aquí
        height: 50.0, // Añade la altura del diálogo aquí
        child: content,
      ),
      color: Colors.green.shade900,
      textHideDialog: 'Aceptar',
      showActions: showActions,
    );
  }


  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  void _navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.green.shade800,
        title: const Center(
          // Envuelve el Text con un Center
          child: Text(
            'GreenFlow',
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Arial',
            ),
          ),
        ),
        // Añade tus acciones o imagen aquí si es necesario
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/logo/icono.png', // Ruta relativa a la imagen
                  width: 220, // Ajusta el ancho según tus necesidades
                  height: 220, // Ajusta la altura según tus necesidades
                ),
                const SizedBox(height: 25.0),
                const Center(
                  child: Text(
                    'Inicio de sesión',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Arial',
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24.0),
                _isDoingRequest == true
                    ? const Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: SizedBox(
                            height: 40.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                                  strokeWidth: 5.0,
                            ),
                          ),
                        )],
                    )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, // Color del texto
                          backgroundColor:
                              Colors.green.shade800, // Color del botón
                        ),
                        onPressed: () async {
                          _isDoingRequest = true;
                          setState(() {});
                          await _login();
                        },
                        child: const Text(
                            'Login'), // Cambia aquí por la función _login
                      ),
                TextButton(
                  onPressed: _navigateToRegister,
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '¿No tienes cuenta?, ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'regístrate aquí.',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
