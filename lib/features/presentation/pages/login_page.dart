import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reservas_app/core/constants/k_padding.dart';
import 'package:reservas_app/features/presentation/blocs/login/login_bloc.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body:  LoginView(),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          toastification.show(
            context: context,
            title: const Text('¡Éxito!'),
            description: const Text('Inicio de sesión exitoso'),
            type: ToastificationType.success,
            autoCloseDuration: const Duration(seconds: 3),
          );
          // Navegar a la página principal
          context.go('/home');
        } else if (state.status == LoginStatus.failure) {
          toastification.show(
            context: context,
            title: const Text('Error'),
            description: Text(state.errorMessage ?? 'Error desconocido'),
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          );
        }
      },
      child: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary.withOpacity(0.1),
                theme.colorScheme.secondary.withOpacity(0.1),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: KPadding.allMD,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Header
                  Card(
                    elevation: 8,
                    child: Padding(
                      padding: KPadding.allMD,
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 80,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Reservas App',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Inicia sesión para continuar',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Formulario
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: KPadding.allMD,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Credenciales',
                              style: theme.textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            
                            // Username Field
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.username != current.username ||
                                  previous.isUsernameValid != current.isUsernameValid,
                              builder: (context, state) {
                                return TextFormField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    labelText: 'Usuario',
                                    prefixIcon: const Icon(Icons.person),
                                    errorText: state.username.isNotEmpty && !state.isUsernameValid
                                        ? 'Usuario debe tener al menos 3 caracteres'
                                        : null,
                                  ),
                                  onChanged: (value) => context
                                      .read<LoginBloc>()
                                      .add(LoginUsernameChanged(value)),
                                  textInputAction: TextInputAction.next,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            
                            // Password Field
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.password != current.password ||
                                  previous.isPasswordValid != current.isPasswordValid,
                              builder: (context, state) {
                                return TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Contraseña',
                                    prefixIcon: const Icon(Icons.lock),
                                    errorText: state.password.isNotEmpty && !state.isPasswordValid
                                        ? 'Contraseña debe tener al menos 6 caracteres'
                                        : null,
                                  ),
                                  onChanged: (value) => context
                                      .read<LoginBloc>()
                                      .add(LoginPasswordChanged(value)),
                                  textInputAction: TextInputAction.next,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            // Login Button
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: state.isFormValid && state.status != LoginStatus.loading
                                      ? () => _submitForm(context)
                                      : null,
                                  child: state.status == LoginStatus.loading
                                      ? LoadingAnimationWidget.staggeredDotsWave(
                                          color: Colors.white,
                                          size: 24,
                                        )
                                      : const Text('Iniciar Sesión'),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Footer
                  Text(
                    '© 2025 Reservas App',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.6),
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

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(const LoginSubmitted());
    }
  }
}
