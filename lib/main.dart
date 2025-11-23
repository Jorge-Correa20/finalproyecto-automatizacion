import 'package:flutter/material.dart';

// Definimos los posibles estados de la manzana para la simulación
enum AppleCondition {
  ripe, // Madura
  spoiled // Malograda
}

void main() {
  runApp(const MyApp());
}

// ----------------------------------------------------
// 1. Estructura Base de la Aplicación (Widget Raíz)
// ----------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clasificador de Manzanas Simulado', // Nombre de la aplicación
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug
      theme: ThemeData(
        // Configuración básica del tema
        primarySwatch: Colors.green, 
        useMaterial3: true,
      ),
      // La página de inicio es nuestra pantalla de estado
      home: const AppleStatusScreen(), 
    );
  }
}

// ----------------------------------------------------
// 2. Pantalla de Estado del Clasificador (StatefulWidget)
// ----------------------------------------------------
class AppleStatusScreen extends StatefulWidget {
  const AppleStatusScreen({super.key});

  @override
  State<AppleStatusScreen> createState() => _AppleStatusScreenState();
}

class _AppleStatusScreenState extends State<AppleStatusScreen> {
  // Variables de Estado Local
  AppleCondition _currentCondition = AppleCondition.ripe; // Empieza como Madura

  // Función para alternar el estado (simula el dato de la nube)
  void _toggleCondition() {
    setState(() {
      if (_currentCondition == AppleCondition.ripe) {
        _currentCondition = AppleCondition.spoiled;
      } else {
        _currentCondition = AppleCondition.ripe;
      }
    });
  }

  // Lógica para determinar el texto y el color basado en el estado local
  String get _appleStatusText {
    return _currentCondition == AppleCondition.ripe ? 'MADURO' : 'MALOGRADA';
  }

  Color get _statusColor {
    return _currentCondition == AppleCondition.ripe 
        ? Colors.green.shade800 // Verde para Madura
        : Colors.red.shade800; // Rojo para Malograda
  }

  // ----------------------------------------------------
  // 3. Diseño de la Interfaz de Usuario
  // ----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detección de estado de manzana'),
        backgroundColor: _statusColor,
        foregroundColor: Colors.white,
        elevation: 4,
        // Eliminamos el botón de refrescar, ya que no hay conexión a la nube
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Estado de la Manzana:',
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.w300, 
                  color: Colors.black87
                ),
              ),
              const SizedBox(height: 40),
              
              // Contenedor principal con el estado y color de fondo
              Container(
                width: MediaQuery.of(context).size.width * 0.8, // 80% del ancho
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: _statusColor,
                  borderRadius: BorderRadius.circular(20), 
                  boxShadow: [
                    BoxShadow(
                      color: _statusColor.withValues(),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  _appleStatusText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Indicador del modo de simulación
              Text(
                'Toca el botón flotante para alternar el estado.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
      
      // Botón flotante para simular la nueva lectura
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggleCondition,
        label: Text(_currentCondition == AppleCondition.ripe ? 'Simular MALOGRADA' : 'Simular MADURO'),
        icon: Icon(_currentCondition == AppleCondition.ripe ? Icons.bug_report : Icons.check_circle),
        backgroundColor: _statusColor,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
