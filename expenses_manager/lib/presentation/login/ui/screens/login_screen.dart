import 'package:expenses_manager/presentation/login/bloc/login_bloc.dart';
import 'package:expenses_manager/presentation/login/ui/widgets/header.dart';
import 'package:expenses_manager/presentation/login/ui/widgets/social_button.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:expenses_manager/utils/validate_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo o ícono de la app
                  Header(icon: Icons.bubble_chart_outlined, title: 'Bienvenido de vuelta'),
                  const SizedBox(height: 32),
                  
                  // Formulario de email
                  TextFormField(
                    controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => validateEmail(value),
                    ),
              
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return 'Insert a password';
                        }
                        else if (value.length < 6){
                          return 'Password must be at least 6 characters lenght';
                        }
                        return null;
                      },
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
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state.uistate.status == UIStatus.error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.uistate.errorMessage),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                      if (state.uistate.status == UIStatus.success) {
                        Navigator.pushReplacementNamed(context, 'root');
                      }
                    },
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        final loading = state.uistate.status == UIStatus.loading;

                        return ElevatedButton(
                          onPressed: loading ? null : () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<LoginBloc>(context).add(Login(email: _emailController.text, password: _passwordController.text));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.grey.shade300,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text('Log in'),
                          )
                        );
                      },
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
      ),
    );
  }
}