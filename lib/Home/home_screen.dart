import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
      ),


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pantalla de inicio'),
            const SizedBox(height: 30),
            const Spacer(),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('Botón adicional'),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Acción al presionar el botón de búsqueda
              },
            ),
            IconButton(
              icon: const Icon(Icons.camera),
              onPressed: () {
                // Acción al presionar el botón de cámara
              },
            ),
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                // Acción al presionar el botón de mapa
              },
            ),
          ],
        ),
      ),
    );
  }
}