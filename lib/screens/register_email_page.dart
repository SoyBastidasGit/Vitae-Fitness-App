import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitae_fitness/screens/login_page.dart';
import 'package:vitae_fitness/services/https.dart';
import 'package:vitae_fitness/services/providers.dart';
import 'package:vitae_fitness/themes.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2006), // Fecha inicial
      firstDate: DateTime(1900), // Fecha mínima
      lastDate: DateTime.now(), // Fecha máxima es la actual
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _saveData() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    // Guardar los valores ingresados en variables
    String nombre = _nameController.text;
    String apellido = _lastnameController.text;
    String email = _emailController.text;
    String birthDate = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : '';
    String password = _passwordController.text;

    // Validación para asegurarse que los campos no estén vacíos
    if (nombre.isEmpty ||
        apellido.isEmpty ||
        email.isEmpty ||
        birthDate.isEmpty ||
        password.isEmpty) {
      // Mostrar un mensaje de error o un dialogo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    profileProvider.name = nombre;
    profileProvider.lastname = apellido;
    profileProvider.email = email;
    profileProvider.birthDate = DateTime.parse(birthDate);
    profileProvider.password = password;

    try {
      final response = await ApiService.registerUser(
        profileProvider.name,
        profileProvider.lastname,
        profileProvider.email,
        profileProvider.birthDate.toString(),
        profileProvider.password,
      );

      final responseData = jsonDecode(response);
      final message = responseData['message'] ?? 'Ocurrió un error inesperado';

      _showDialog('Registrado correctamente', message, () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      });
    } catch (error) {
      _showDialog('Error',
          'Ocurrió un error al guardar los datos. Por favor, inténtalo de nuevo.\nError: $error',
          () {
        Navigator.pop(context);
      });
    }
  }

  void _showDialog(String title, String content, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                color: AppTheme.primaryColor,
                scale: 2,
              ),
              const SizedBox(height: 50),
              Text(
                'Vitae Fitness',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),

              // Campo de email
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              // Campo de email
              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              // Campo de email
              SizedBox(
                height: 50,
                child: TextField(
                  controller: TextEditingController(
                    text: _selectedDate == null
                        ? ''
                        : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Fecha de Nacimiento',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon:
                        Icon(Icons.calendar_today, color: Colors.grey[600]),
                  ),
                  readOnly: true, // Evitar que el usuario escriba en el campo
                  onTap: () => _selectDate(
                      context), // Abre el selector de fecha al tocar el campo
                ),
              ),
              const SizedBox(height: 20),
              // Campo de email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  hintText: 'ejemplo@ejemplo.com',
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              // Campo de contraseña
              TextFormField(
                controller: _passwordController,
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
              const SizedBox(height: 20),

              // Botón de Registro
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveData,
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(color: AppTheme.textColorButtonPrimary),
                  ),
                ),
              ),
              const Spacer(),

              // Botón de inicio de sesión
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) =>
                        false, // Elimina todas las rutas anteriores
                  );
                },
                child: const Text(
                  '¿Ya tienes una cuenta? Inicia sesión.',
                  style: TextStyle(color: AppTheme.secondaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
