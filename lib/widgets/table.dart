import 'package:flutter/material.dart';
import 'package:vitae_fitness/themes.dart';

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
          'Contenido',
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
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10))),
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
