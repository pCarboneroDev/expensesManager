String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please, insert an email';
  }
  
  // Expresión regular para email - CORREGIDA
  final emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
  
  if (!emailRegExp.hasMatch(value)) {
    return 'Please insert a valid email address';
  }
  
  // Verificar longitud del dominio
  final parts = value.split('@');
  if (parts.length != 2) {
    return 'Invalid email address';
  }
  
  final domainParts = parts[1].split('.');
  if (domainParts.length < 2) {
    return 'The email domain must have at least one dot';
  }
  
  final lastPart = domainParts.last;
  if (lastPart.length < 2) {
    return 'Domain extension must have at least 2 characters';
  }
  
  return null;
}