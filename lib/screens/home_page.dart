import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vitae_fitness/screens/assistance_page.dart';
import 'package:vitae_fitness/screens/profile_page.dart';
import 'package:vitae_fitness/screens/video_list_page.dart';
import 'package:vitae_fitness/services/providers.dart';
import 'package:vitae_fitness/themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            children: [
              Image.asset(
                'assets/images/logo.png',
                color: AppTheme.primaryColor,
                scale: 2,
              ),
              const SizedBox(height: 30),
              Text(
                '¡Buen dia, ${profileProvider.name}!',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ejercicios semanales',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Tabla de Planeación Semanal
              Container(
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
                    buildStyledRow('Lunes', 'Cardio y Piernas'),
                    buildStyledRow('Martes', 'Espalda y Bíceps'),
                    buildStyledRow('Miércoles', 'Descanso'),
                    buildStyledRow('Jueves', 'Pecho y Tríceps'),
                    buildStyledRow('Viernes', 'Hombros y Core'),
                    buildStyledRow('Sábado', 'Piernas y Glúteos'),
                    buildStyledRow('Domingo', 'Descanso o Yoga'),
                  ],
                ),
              ),
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
                            ElevatedButton(
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
                            ElevatedButton(
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

  TableRow buildHeaderRow() {
    return const TableRow(
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(10))),
      children: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Día',
            style: TextStyle(
              color: AppTheme.textColorButtonPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Ejercicio',
            style: TextStyle(
              color: AppTheme.textColorButtonPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  TableRow buildStyledRow(String day, String workout) {
    return TableRow(
      decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10))),
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            day,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            workout,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
