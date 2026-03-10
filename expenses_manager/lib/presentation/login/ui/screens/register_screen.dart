import 'package:expenses_manager/presentation/login/bloc/login_bloc.dart';
import 'package:expenses_manager/presentation/login/ui/widgets/header.dart';
import 'package:expenses_manager/presentation/login/ui/widgets/social_button.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:expenses_manager/utils/validate_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool check = false;
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
                  Header(icon: Icons.chat_bubble_outline, title: "Registratee"),

                  const SizedBox(height: 32),

                  // Formulario de registro
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Full name',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value != null && value.length < 3) {
                        return 'Must be at least 3 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

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
                      if (value == null || value.isEmpty) {
                        return 'Insert a password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters lenght';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insert a password';
                      } else if (value != _passwordController.text) {
                        return 'Password must be equals';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters lenght';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Checkbox de términos
                  Row(
                    children: [
                      Checkbox(
                        value: check,
                        onChanged: (value) {
                          setState(() {
                            check = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Acepto los Términos y Condiciones y la Política de Privacidad',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Botón de registrarse
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
                            if (_formKey.currentState!.validate() && check) {
                              BlocProvider.of<LoginBloc>(context).add(Register(email: _emailController.text, password: _passwordController.text));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.grey.shade300,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text('Registrarse'),
                          )
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Botón para ir a login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿Ya tienes una cuenta?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Inicia sesión'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Separador
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('O regístrate con'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Botones sociales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialButton(icon: Icons.g_mobiledata, onPressed: () {}),
                      SocialButton(icon: Icons.facebook, onPressed: () {}),
                      SocialButton(icon: Icons.apple, onPressed: () {}),
                    ],
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
