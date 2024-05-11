import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

// Clase principal de la aplicación
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dibujar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// Página principal de la aplicación
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? figura; // Inicializar como nula
  TextEditingController controller = TextEditingController(); // Controlador para el campo de texto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dibujar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Campo de texto para ingresar el tipo de figura
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Escribe triangulo o cuadrado:',
              ),
              onChanged: (value) {
                figura = value.toLowerCase(); // Actualiza el tipo de figura cuando se cambia el texto
              },
            ),
            SizedBox(height: 20),
            // Botón para aceptar y dibujar la figura
            ElevatedButton(
              onPressed: () {
                if (figura != null && figura!.isNotEmpty) {
                  dibujarFigura(figura!);
                }
              },
              child: Text('Aceptar'),
            ),
            SizedBox(height: 20),
            // Área de dibujo personalizado para mostrar la figura
            if (figura != null && figura!.isNotEmpty) // Mostrar solo si figura no es nula ni vacía
              CustomPaint(
                size: Size(200, 200),
                painter: FiguraPainter(figura!),
              ),
          ],
        ),
      ),
    );
  }

  // Método para dibujar la figura especificada
  void dibujarFigura(String figura) {
    setState(() {
      controller.clear(); // Limpiar el campo de texto
      figura = figura.toLowerCase(); // Convertir el texto a minúsculas
    });
  }
}



// Clase para dibujar la figura en el área de dibujo personalizado
class FiguraPainter extends CustomPainter {
  final String figura;

  FiguraPainter(this.figura);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill; // Cambiar a PaintingStyle.fill para rellenar la figura

    // Dibujar el triángulo si figura es "triángulo"
    if (figura == "triangulo") {
      paint.color = Colors.blue; // Establecer el color azul
      Path path = Path();
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
    // Dibujar el cuadrado si figura es "cuadrado"
    else if (figura == "cuadrado") {
      paint.color = Colors.yellow; // Establecer el color amarillo
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    }
    // Mostrar un mensaje si la figura no es reconocida
    else {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: "Figura no encontrada.",
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout(minWidth: size.width, maxWidth: size.width);
      textPainter.paint(canvas, Offset(0, size.height / 2 - 10));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

