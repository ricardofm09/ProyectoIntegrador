import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:greenflow/services/auth/auth.dart';

import '../Login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  int _selectedAge = 0;
  final AuthService _authService = AuthService();
  bool _isDoinRequest = false;

  //Función para validar el correo electrónico
  bool validateEmail(String email) {
    if (!email.contains('@')) {
      showSnackBar('Por favor ingrese un correo electrónico válido');
      _isDoinRequest = false;
      setState(() {  });
      return false;
    }

    //Validar el dominio del correo al final (upq.mx y upq.edu.mx)
    if (!email.endsWith('upq.mx') &&
        !email.endsWith('upq.edu.mx') &&
        !email.endsWith('gmail.com') &&
        !email.endsWith('hotmail.com')) {
      showSnackBar('Por favor ingrese un correo electrónico válido');
      _isDoinRequest = false;
      setState(() {  });
      return false;
    }

    return true;
  }

  Future<void> _registerAccount() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String name = _nameController.text.trim();
    String lastname = _lastnameController.text.trim();
    int age = _selectedAge;

    // Validar datos
    if (password != confirmPassword) {
      _isDoinRequest = false;
      setState(() {  });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden.')),
      );

      return;
    }
    if (name.isNotEmpty) {
      if (lastname.isNotEmpty) {
        if (age != 0) {
          if (email.isNotEmpty) {
            if (validateEmail(email)) {
              // Llamada a la función validateEmail
              if (password.isNotEmpty) {
                if (password.length >= 8) {
                  bool isRegister =
                      await _authService.registro(email, password);

                  if (isRegister) {
                    // Guardas el resto de los datos en la BD
                    String uid = _authService.getUserUid();

                    DatabaseReference dbRef =
                        FirebaseDatabase.instance.ref().child('Registro');

                    await dbRef.child(uid).set({
                      'nombre': name,
                      'apellido': lastname,
                      'email': email,
                      'edad': age,
                      // Puedes agregar más campos si lo necesitas
                    });
                    showSnackBar('Se registro exitantemente');
                    _navigateToLogin();
                  } else {
                    showSnackBar('Ya existe este correo, intenta con otro.');
                    //testear errores cuando se muestre este mensaje
                    _isDoinRequest = false;
                  }
                } else {
                  showSnackBar('Tu contraseña no cuenta con 8 caracteres.');
                  _isDoinRequest = false;
                }
              } else {
                showSnackBar('Necesitas poner una contraseña.');
                _isDoinRequest = false;
              }
            } else {
              showSnackBar('Necesitas poner un correo electronico válido.');
              _isDoinRequest = false;
            }
          } else {
            showSnackBar('Necesitas poner un correo electronico.');
            _isDoinRequest = false;
          }
        } else {
          showSnackBar('Necesitas poner tu edad.');
          _isDoinRequest = false;
        }
      } else {
        showSnackBar('Necesitas poner un apellido.');
        _isDoinRequest = false;
      }
    } else {
      showSnackBar('Necesitas poner un nombre.');
      _isDoinRequest = false;
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToLogin() {

    _isDoinRequest = false;
    setState(() {  });
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginScreen(),));
  }

  void _setAge(int? ageSelected){
    _selectedAge = ageSelected ?? 0;
    setState(() {  });
  }

  List<DropdownMenuItem<int>> get _ageItems{
    List<DropdownMenuItem<int>> menuItems = [];
    for(int i = 0; i <= 100; i++){
      menuItems.add(DropdownMenuItem(
          value: i, child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(i.toString(),
                  ),
          ),
      ),
      );
    }
    return menuItems;
  }
  

  Widget _ageSelector(){

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade600),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: <Widget>[
           const Text('Edad:'),
          Expanded(
            child: Container(
              //padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: DropdownButton<int>(
                isExpanded: true,
                value: _selectedAge,
                items: _ageItems,
                onChanged: _setAge,
                menuMaxHeight: 300,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _oldAgeSelector(){
    return                 PopupMenuButton<int>(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade600),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Edad: $_selectedAge'),
            const Icon(Icons.arrow_drop_down), // Agrega un ícono de flecha hacia abajo
          ],
        ),
      ),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<int>>[
          PopupMenuItem<int>(
            value: _selectedAge, // Añade esta línea
            child: Container(
              height: 200, // Ajusta este valor según sea necesario
              width: 85, // Ajusta este valor según sea necesario
              child: ListView.builder(
                itemCount: 95,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector( // Envuelve tu Container con GestureDetector
                    onTap: () {
                      Navigator.pop(context, index + 5); // Cierra el menú y pasa el valor seleccionado
                    },
                    child: Container(
                      height: 35, // Ajusta la altura para evitar el empalme
                      alignment: Alignment.center, // Centra el contenido vertical y horizontalmente
                      child: Text('${index + 5}'),
                    ),
                  );
                },
              ),
            ),
          ),
        ];
      },
      onSelected: (int newValue) {
        setState(() {
          _selectedAge = newValue;
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        leading: IconButton(
          padding: const EdgeInsets.only(right: 0),
          icon: const Icon(
            Icons.arrow_back,
            size: 23.0,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Transform.translate(
          offset: const Offset(-20.0, 0),
          child: const Text(
            'Regresar',
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Arial',
            ),
          ),
        ),
        backgroundColor: Colors.green.shade800,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                // Acción al tocar la imagen
              },
              child: Image.asset(
                'assets/logo/icono.png', // Ruta de tu imagen
                fit: BoxFit.cover,
                height: 40.0, // Ajusta la altura según sea necesario
              ),
            ),
          ),
        ],
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
                const Center(
                  child: Text(
                    'REGISTRO',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Arial',
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombres',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _lastnameController,
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                ),
                //_ageSelector(),
                _ageSelector(),
                //_oldAgeSelector(),

                const SizedBox(height: 16.0),
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
                const Padding(
                  padding: EdgeInsets.only(
                      left: 10.0, top: 5.0, right: 0.0, bottom: 0.0),
                  child: Text("Minimo 8 caracteres"),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30.0),
                _isDoinRequest == true ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: SizedBox(
                      height: 40.0,
                      width: 40.0,
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 5.0,
                      ),
                    ),
                  )],
                ) :
                ElevatedButton(
                  onPressed: () async {
                    _isDoinRequest = true;
                    setState(() {      });
                    _registerAccount();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green.shade800,
                  ),
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
