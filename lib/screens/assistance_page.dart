import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssistancePage extends StatelessWidget {
  const AssistancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistencia'), // Clear and concise title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Navigate back to home
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0), // Consistent padding
        child: SingleChildScrollView(
          // Allow for scrolling if content overflows
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align content to left
            children: [
              Text(
                '¿Necesitas ayuda?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0), // Spacing between sections
              Text(
                'Aquí encontrarás respuestas a las preguntas más frecuentes sobre Vitae Fitness y nuestra aplicación.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),

              // FAQs section using ExpansionTile for collapsible content
              ExpansionTile(
                title: Text('¿Cómo funciona la planificación semanal?'),
                children: [
                  Text(
                    'La planificación semanal te brinda una guía sugerida de ejercicios para cada día de la semana, teniendo en cuenta diferentes grupos musculares. Puedes personalizarla según tus necesidades y preferencias.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              ExpansionTile(
                title: Text('¿Cómo puedo contactar con el soporte técnico?'),
                children: [
                  Column(
                    children: [
                      Text(
                        'Puedes contactarnos a través de las siguientes opciones:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.envelope, size: 16.0),
                          SizedBox(width: 8.0),
                          Text(
                            'soporte@vitaefitness.com',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.phone, size: 16.0),
                          SizedBox(width: 8.0),
                          Text(
                            '+1 (555) 555-5555', // Replace with actual phone number
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
