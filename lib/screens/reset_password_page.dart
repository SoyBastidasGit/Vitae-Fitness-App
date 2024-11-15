import 'package:flutter/material.dart';
import 'package:vitae_fitness/services/https.dart';
import 'package:vitae_fitness/themes.dart';
import 'package:vitae_fitness/widgets/loading_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _resetPassword(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage(
          'Por favor, ingresa tu correo electrónico y contraseña nueva');
      return;
    }

    // Mostrar la pantalla de carga
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingPage();
      },
    );

    // Cierra la pantalla de carga
    Navigator.pop(context);

    // Llamada al servicio de restablecimiento de contraseña
    var response = await ApiService.resetPassword(email, password);

    if (response.containsKey('message') &&
        response['message'] == 'Contraseña actualizada correctamente') {
      _showMessage('Contraseña reestablecida');
    } else {
      _showMessage('Error del servidor. Inténtalo nuevamente mas tarde');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Restablece tu contraseña',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Ingresa tu correo electrónico para restablecer tu contraseña.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Correo',
                hintText: 'ejemplo@ejemplo.com',
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Nueva contraseña',
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _resetPassword(context);
                },
                child: const Text(
                  'Enviar',
                  style: TextStyle(color: AppTheme.textColorButtonPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
