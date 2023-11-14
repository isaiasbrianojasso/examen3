import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Map<String, dynamic>? jsonResponse;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController();
    claveController = TextEditingController();
    horaController = TextEditingController();
  }

  Future<void> enviarDatos() async {
    final url = Uri.parse(
        'http://nrweb.com.mx/api_prueba/examen/parcial3.php?nombre=${nombreController.text}&clave=${claveController.text}&hora=${horaController.text}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        jsonResponse = json.decode(response.body);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Conectado'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      print('Error en la solicitud POST');
      print('Código de estado: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error en la solicitud POST'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Campos de entrada para el nombre, clave y hora
              for (var controller in [
                nombreController,
                claveController,
                horaController
              ])
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: controller == nombreController
                          ? 'Nombre'
                          : controller == claveController
                              ? 'Clave'
                              : 'Hora',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  print('Enviando');
                  print('Nombre: ${nombreController.text}');
                  print('Clave: ${claveController.text}');
                  print('Hora: ${horaController.text}');
                  enviarDatos();
                },
                icon: Icon(Icons.refresh), // Icono de recarga
                label: Text('Recargar'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Color de fondo naranja
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),

              if (jsonResponse != null)
                Card(
                  margin: EdgeInsets.all(16),


                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Respuesta:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        for (var item in jsonResponse!['respuesta'])
                          Card(
                            margin: EdgeInsets.all(10),
                            color: item['pais_origen'] == 'México'
                                ? Colors.blueAccent
                                : Colors.black,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nombre: ${item['nombre']}'),
                                  Text(
                                      'Apellido Paterno: ${item['apellido_paterno']}'),
                                  Text(
                                      'Apellido Materno: ${item['apellido_materno']}'),
                                  Text('Edad: ${item['edad']}'),
                                  Text(
                                    'País de Origen: ${item['pais_origen']}',

                                  ),
                                  Text('Teléfono: ${item['telefono']}'),
                                  Text('Email: ${item['email']}'),
                                  Text(
                                    'Calificación: ${item['calificacion']}',
                                    style: TextStyle(
                                      fontSize: item['calificacion'] > 80
                                          ? 20
                                          : item['calificacion'] > 60
                                              ? 18
                                              : 15,
                                      color: item['calificacion'] > 80
                                          ? Colors.green
                                          : item['calificacion'] > 60
                                              ? Colors.orange
                                              : Colors.red,
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
            ],
          ),
        ),
      ),
    );
  }
}
