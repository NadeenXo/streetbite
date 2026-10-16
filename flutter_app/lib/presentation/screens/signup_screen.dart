import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../blocs/auth/auth_cubit.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/auth_failure_message.dart';
import '../widgets/auth_validators.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = MediaQuery.sizeOf(context).width < 400 ? 16.0 : 24.0;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, current) =>
          (current is AuthError && current.action == AuthAction.signUp) ||
          current is AuthAuthenticated,
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.of(context).pop();
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AuthFailureMessage.forFailure(state.failure, l10n)),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.authSignUp)),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      key: const Key('signup_name'),
                      controller: _name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(labelText: l10n.authFullName),
                      validator: (v) => AuthValidators.name(v, l10n),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const Key('signup_email'),
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: l10n.authEmail),
                      validator: (v) => AuthValidators.email(v, l10n),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const Key('signup_password'),
                      controller: _password,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: l10n.authPassword,
                        suffixIcon: IconButton(
                          tooltip: _obscure
                              ? l10n.authShowPassword
                              : l10n.authHidePassword,
                          icon: Icon(
                            _obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) => AuthValidators.password(v, l10n),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const Key('signup_confirm'),
                      controller: _confirm,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: l10n.authConfirmPassword,
                      ),
                      validator: (v) =>
                          AuthValidators.confirm(v, _password.text, l10n),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final loading =
                            state is AuthLoading &&
                            state.action == AuthAction.signUp;
                        return FilledButton(
                          key: const Key('signup_submit'),
                          onPressed: loading
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context.read<AuthCubit>().signUp(
                                    fullName: _name.text,
                                    email: _email.text,
                                    password: _password.text,
                                  );
                                },
                          child: loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(l10n.authSignUp),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
