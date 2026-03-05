import 'package:expenses_manager/presentation/login/ui/widgets/social_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo o ícono de la app
                const Icon(
                  Icons.chat_bubble_outline,
                  size: 80,
                ),
                const SizedBox(height: 32),
                
                // Título de la app
                const Text(
                  'Bienvenido de vuelta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Formulario de email
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                
                // Enlace de olvidé contraseña
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('¿Olvidaste tu contraseña?'),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Botón de iniciar sesión
                ElevatedButton(
                  onPressed: () {
                    //Navigator.pushReplacementNamed(context, 'root');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Iniciar sesión'),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Botón para usuarios no registrados
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿No tienes una cuenta?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child: const Text('Regístrate'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Separador con texto
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('O continúa con'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Botones de proveedores externos
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(
                      icon: Icons.g_mobiledata,
                      onPressed: () {},
                    ),
                    SocialButton(
                      icon: Icons.facebook,
                      onPressed: () {},
                    ),
                    SocialButton(
                      icon: Icons.apple,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                // Términos y condiciones
                const Text(
                  'Al continuar, aceptas nuestros Términos y Condiciones y Política de Privacidad',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}