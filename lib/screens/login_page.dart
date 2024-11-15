import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitae_fitness/screens/home_page.dart';
import 'package:vitae_fitness/screens/register_email_page.dart';
import 'package:vitae_fitness/screens/reset_password_page.dart';
import 'package:vitae_fitness/services/https.dart';
import 'package:vitae_fitness/services/providers.dart';
import 'package:vitae_fitness/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vitae_fitness/widgets/loading_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _login(context, profileProvider) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Por favor, completa todos los campos');
      return;
    }

    // Mostrar la pantalla de carga
    showDialog(
      context: context,
      barrierDismissible: false, // Impide que el usuario cierre el diálogo
      builder: (BuildContext context) {
        return const LoadingPage();
      },
    );

    // Cierra la pantalla de carga
    Navigator.pop(context);

    // Llama a la función de login desde el servicio HTTP
    var response = await ApiService.loginUser(email, password);

    if (response.containsKey('message') &&
        response['message'] == 'Autorizado') {
      profileProvider.name = response['result'][0]['nombre'];
      profileProvider.lastname = response['result'][0]['apellido'];
      profileProvider.birthDate =
          DateTime.parse(response['result'][0]['fecha_nacimiento']);
      profileProvider.email = response['result'][0]['correo'];

      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
        (route) => false,
      );
    } else if (response.containsKey('error')) {
      _showMessage(response['error']);
    } else {
      _showMessage('Correo o contraseña incorrectos');
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
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 16, left: 40, right: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¡Bienvenido/a! ¡Comienza tu transformación hoy mismo!',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const Spacer(),
              Image.asset(
                'assets/images/logo.png',
                color: AppTheme.primaryColor,
                scale: 2,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Vitae Fitness',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),

              const Text(
                '-  -  -  -  -  -  iniciar Sesion  -  -  -  -  -  -',
                style: TextStyle(color: AppTheme.secondaryColor),
              ),

              const Spacer(),
              // Campo de email
              TextFormField(
                controller: emailController, // Asocia el controlador aquí
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  hintText: 'ejemplo@ejemplo.com',
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),

              // Campo de contraseña
              TextFormField(
                controller: passwordController, // Asocia el controlador aquí
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              // Enlace de "Forgot Password"
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordPage(),
                      ),
                    );
                  },
                  child: const Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(color: AppTheme.secondaryColor),
                  ),
                ),
              ),

              // Botón de Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _login(context, profileProvider);
                  },
                  child: const Text(
                    'Iniciar sesion',
                    style: TextStyle(color: AppTheme.textColorButtonPrimary),
                  ),
                ),
              ),
              const Spacer(),

              const Text(
                '-  -  -  -  Registrate  -  -  -  -',
                style: TextStyle(color: AppTheme.secondaryColor),
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón de iniciar sesión con Google
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: null,
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        size: 16,
                      ),
                      label: const Text(
                        'Con Google',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Botón de iniciar sesión con Email
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.email_outlined,
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                      label: Text(
                        'Con Email',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color),
                      ),
                    ),
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
