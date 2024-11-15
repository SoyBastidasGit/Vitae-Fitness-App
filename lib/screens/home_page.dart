import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vitae_fitness/screens/assistance_page.dart';
import 'package:vitae_fitness/screens/profile_page.dart';
import 'package:vitae_fitness/screens/video_list_page.dart';
import 'package:vitae_fitness/services/providers.dart';
import 'package:vitae_fitness/themes.dart';
import 'package:vitae_fitness/widgets/table.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isExerciseSelected = true; // Controla cuál de las tablas mostrar

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserProfilePage(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AssistancePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                color: AppTheme.primaryColor,
                scale: 2,
              ),
              const SizedBox(height: 30),
              Text(
                '¡Buen día, ${profileProvider.name}!',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Columna para el Plan Nutricional
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/plan_nutricional.png',
                        scale: 3,
                        color: AppTheme.textColor,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          showPlanModal(context, false);
                        },
                        child: const Text('Plan nutricional'),
                      ),
                    ],
                  ),

                  // Columna para el Plan Ejercicio
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/plan_ejercicio.png',
                        scale: 3,
                        color: AppTheme.textColor,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          showPlanModal(context, true);
                        },
                        child: const Text('Plan ejercicio'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Spacer(),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.bars,
                  color: Colors.white,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        color: Colors.black87,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VideoListPage(
                                          title: 'Quemar Grasa',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Quemar Grasa"),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VideoListPage(
                                          title: 'Aumento Muscular',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Aumento Muscular"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Función que muestra el modal con la tabla de ejercicios o nutrición
  void showPlanModal(BuildContext context, bool isExerciseSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            isExerciseSelected ? 'Ejercicios semanales' : 'Plan nutricional',
            style: const TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            // Hace que el contenido sea desplazable si es necesario
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Table(
                border: TableBorder.all(
                  color: Colors.grey[700]!,
                  width: 1,
                  borderRadius: BorderRadius.circular(10),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: [
                  buildHeaderRow(),
                  if (isExerciseSelected) ...[
                    buildStyledRow('Lunes', 'Cardio y Piernas'),
                    buildStyledRow('Martes', 'Espalda y Bíceps'),
                    buildStyledRow('Miércoles', 'Descanso'),
                    buildStyledRow('Jueves', 'Pecho y Tríceps'),
                    buildStyledRow('Viernes', 'Hombros y Core'),
                    buildStyledRow('Sábado', 'Piernas y Glúteos'),
                    buildStyledRow('Domingo', 'Descanso o Yoga'),
                  ] else ...[
                    buildStyledRow('Lunes',
                        'Desayuno: Avena y fruta\nAlmuerzo: Pollo con arroz y ensalada'),
                    buildStyledRow('Martes',
                        'Desayuno: Yogur y granola\nAlmuerzo: Pescado con vegetales'),
                    buildStyledRow('Miércoles',
                        'Desayuno: Huevos revueltos con pan integral\nAlmuerzo: Tofu con quinoa'),
                    buildStyledRow('Jueves',
                        'Desayuno: Smoothie verde\nAlmuerzo: Carne magra con brócoli'),
                    buildStyledRow('Viernes',
                        'Desayuno: Tostadas con aguacate\nAlmuerzo: Pollo con pasta integral'),
                    buildStyledRow('Sábado',
                        'Desayuno: Panqueques de avena\nAlmuerzo: Ensalada de atún con espinacas'),
                    buildStyledRow('Domingo',
                        'Desayuno: Batido proteico\nAlmuerzo: Sopa de verduras'),
                  ],
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el modal
              },
              child: const Text(
                'Cerrar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
