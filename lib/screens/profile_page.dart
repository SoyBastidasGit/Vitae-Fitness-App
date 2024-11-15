import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitae_fitness/screens/login_page.dart';
import 'package:vitae_fitness/services/https.dart';
import 'package:vitae_fitness/services/providers.dart';
import 'package:vitae_fitness/themes.dart';
import 'package:vitae_fitness/widgets/loading_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> _updateProfile(context, profileProvider) async {
    final name = _nameController.text;
    final lastName = _lastnameController.text;
    final email = _emailController.text;
    final oldEmail = profileProvider.email;

    // Mostrar la pantalla de carga
    showDialog(
      context: context,
      barrierDismissible: false, // Impide que el usuario cierre el diálogo
      builder: (BuildContext context) {
        return const LoadingPage();
      },
    );

    // Llama a la función de login desde el servicio HTTP
    var response =
        await ApiService.updateProfileInfo(name, lastName, email, oldEmail);

    // Cierra la pantalla de carga
    Navigator.pop(context);

    if (response.containsKey('message') &&
        response['message'] == 'Autorizado') {
      profileProvider.name = response['result'][0]['nombre'];
      profileProvider.lastname = response['result'][0]['apellido'];
      profileProvider.email = response['result'][0]['correo'];

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const UserProfilePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    } else if (response.containsKey('error')) {
      _showMessage(response['error']);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);

    // Set initial values for the controllers
    _nameController.text = profileProvider.name;
    _lastnameController.text = profileProvider.lastname;
    _emailController.text = profileProvider.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'),
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              '${profileProvider.name} ${profileProvider.lastname}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              profileProvider.email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // ExpansionTile for editing profile
            ExpansionTile(
              leading: const Icon(Icons.person),
              title: const Text('Editar perfil'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _lastnameController,
                    decoration: const InputDecoration(
                      labelText: 'Apellido',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateProfile(context, profileProvider);
                    // Mostrar un mensaje de éxito o hacer algo al guardar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Perfil actualizado')),
                    );
                  },
                  child: const Text('Guardar cambios'),
                ),
              ],
            ),

            // Other ListTile for settings
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                // Lógica para configuración
              },
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) =>
                      false, // Elimina todas las rutas anteriores
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
