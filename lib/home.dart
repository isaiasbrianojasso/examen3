import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController nombreController;
  late TextEditingController claveController;
  late TextEditingController horaController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController();
    claveController = TextEditingController();
    horaController = TextEditingController();
  }

  @override
  void dispose() {
    nombreController.dispose();
    claveController.dispose();
    horaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Campo de entrada para el nombre
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Campo de entrada para la clave
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: claveController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Clave',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Campo de entrada para la hora
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: horaController,
                decoration: InputDecoration(
                  labelText: 'Hora',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 20),
            // Botón personalizado con fondo naranja y un icono de recarga
            ElevatedButton.icon(
              onPressed: () {
                // Acción a realizar cuando se presiona el botón
                print('Botón presionado');
                print('Nombre: ${nombreController.text}');
                print('Clave: ${claveController.text}');
                print('Hora: ${horaController.text}');
              },
              icon: Icon(Icons.refresh), // Icono de recarga
              label: Text('Recargar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // Color de fondo naranja
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
