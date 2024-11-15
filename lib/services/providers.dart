// Provider para registrar usuario
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = 'User';
  String _lastname = 'Demo';
  String _email = 'example@example.com';
  DateTime _birthDate = DateTime.now();
  String _password = '';

  String get name => _name;
  String get lastname => _lastname;
  String get email => _email;
  DateTime get birthDate => _birthDate;
  String get password => _password;

  set name(String newValue) {
    _name = newValue;
    notifyListeners();
  }

  set lastname(String newValue) {
    _lastname = newValue;
    notifyListeners();
  }

  set email(String newValue) {
    _email = newValue;
    notifyListeners();
  }

  set birthDate(DateTime newValue) {
    _birthDate = newValue;
    notifyListeners();
  }

  set password(String newValue) {
    _password = newValue;
    notifyListeners();
  }

  // Método para actualizar la fecha de nacimiento
  void updateBirthDate(DateTime birthDate) {
    _birthDate = birthDate;
    notifyListeners(); // Notifica a todos los listeners que hubo un cambio
  }

  void updateProfile(String newName, String newLastname, String newEmail) {
    name = newName;
    lastname = newLastname;
    email = newEmail;
    notifyListeners(); // Notificar a los widgets que estén escuchando cambios
  }
}
