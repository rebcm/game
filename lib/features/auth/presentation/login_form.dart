import Intl.message('package:flutter/material.dart');
import Intl.message('package:passdriver/features/auth/domain/auth_usecase.dart');

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authUsecase = AuthUsecase(AuthRepository());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: Intl.message('E-mail')),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: Intl.message('Senha')),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await _authUsecase(_emailController.text, _passwordController.text);
              result.fold(
                (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error))),
                (token) => Navigator.pushReplacementNamed(context, Intl.message('/home')),
              );
            },
            child: Text(Intl.message('Entrar')),
          ),
        ],
      ),
    );
  }
}
