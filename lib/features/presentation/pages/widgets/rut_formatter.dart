import 'package:flutter/services.dart';

class RutFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.toUpperCase();
    
    // Permitir solo dígitos y K
    text = text.replaceAll(RegExp(r'[^0-9K]'), '');
    
    // Si está vacío, retornar vacío
    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    
    // Si tiene más de 9 caracteres, truncar
    if (text.length > 9) {
      text = text.substring(0, 9);
    }
    
    // Si tiene al menos 2 caracteres, agregar el guión
    if (text.length > 1) {
      String body = text.substring(0, text.length - 1);
      String dv = text.substring(text.length - 1);
      text = '$body-$dv';
    }
    
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class RutValidator {
  /// Calcula el dígito verificador de un RUT chileno usando el algoritmo Módulo 11
  static String calculateCheckDigit(String rut) {
    // Remover puntos y guiones
    String cleanRut = rut.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanRut.isEmpty) return '';
    
    // Tomar solo la parte numérica (sin el dígito verificador)
    String rutBody = cleanRut.length > 1 
        ? cleanRut.substring(0, cleanRut.length - 1) 
        : cleanRut;
    
    int sum = 0;
    int multiplier = 2;
    
    // Procesar cada dígito desde la derecha hacia la izquierda
    for (int i = rutBody.length - 1; i >= 0; i--) {
      int digit = int.parse(rutBody[i]);
      sum += digit * multiplier;
      
      // El multiplicador va de 2 a 7 y luego se repite
      multiplier++;
      if (multiplier > 7) {
        multiplier = 2;
      }
    }
    
    // Calcular el módulo 11
    int module = sum % 11;
    int checkDigit = 11 - module;
    
    // Aplicar las reglas específicas del RUT chileno
    if (checkDigit == 11) {
      return '0';
    } else if (checkDigit == 10) {
      return 'K';
    } else {
      return checkDigit.toString();
    }
  }
  
  /// Valida si un RUT chileno es válido
  static bool isValidRut(String rut) {
    if (rut.isEmpty) return false;
    
    // Limpiar el RUT
    String cleanRut = rut.replaceAll(RegExp(r'[^0-9K]'), '').toUpperCase();
    
    if (cleanRut.length < 2) return false;
    
    // Separar cuerpo y dígito verificador
    String rutBody = cleanRut.substring(0, cleanRut.length - 1);
    String providedDv = cleanRut.substring(cleanRut.length - 1);
    
    // Calcular el dígito verificador esperado
    String expectedDv = calculateCheckDigit(rutBody);
    
    return providedDv == expectedDv;
  }
  
  /// Formatea un RUT con puntos y guión
  static String formatRut(String rut) {
    if (rut.isEmpty) return '';
    
    // Limpiar el RUT
    String cleanRut = rut.replaceAll(RegExp(r'[^0-9K]'), '').toUpperCase();
    
    if (cleanRut.length < 2) return cleanRut;
    
    // Separar cuerpo y dígito verificador
    String rutBody = cleanRut.substring(0, cleanRut.length - 1);
    String dv = cleanRut.substring(cleanRut.length - 1);
    
    // Agregar puntos cada tres dígitos desde la derecha
    String formattedBody = '';
    for (int i = 0; i < rutBody.length; i++) {
      if (i > 0 && (rutBody.length - i) % 3 == 0) {
        formattedBody += '.';
      }
      formattedBody += rutBody[i];
    }
    
    return '$formattedBody-$dv';
  }
  
  /// Genera un RUT válido automáticamente (útil para sugerir al usuario)
  static String generateValidRut(String partialRut) {
    if (partialRut.isEmpty) return '';
    
    String cleanRut = partialRut.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanRut.length < 7) return partialRut; // Muy corto para generar
    
    String calculatedDv = calculateCheckDigit(cleanRut);
    return '$cleanRut-$calculatedDv';
  }
}
