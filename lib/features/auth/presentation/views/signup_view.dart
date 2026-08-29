import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/social_login_row.dart';
import '../manager/signup_cubit.dart';
import '../manager/signup_state.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(),
      child: const _SignupBody(),
    );
  }
}

class _SignupBody extends StatefulWidget {
  const _SignupBody();

  @override
  State<_SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<_SignupBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account is created, please sign in')),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Marketi',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: _nameController,
                      label: 'Your Name',
                      hintText: 'Full Name',
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Please enter your name.' : null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _usernameController,
                      label: 'Username',
                      hintText: 'Username',
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Please enter your email.' : null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      hintText: '+20 1501142409',
                      keyboardType: TextInputType.phone,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? ' Please enter your phone number.'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      hintText: 'You@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || !v.contains('@')) {
                          return ' Please enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hintText: 'Password',
                      obscureText: _obscure1,
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscure1 ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscure1 = !_obscure1),
                      ),
                      validator: (v) => (v == null || v.length < 6)
                          ? 'Password must be at least 6 characters long.'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _confirmController,
                      label: 'Confirm Password',
                      hintText: 'Confirm Password',
                      obscureText: _obscure2,
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscure2 ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscure2 = !_obscure2),
                      ),
                      validator: (v) => (v != _passwordController.text)
                          ? 'Passwords do not match.'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Sign Up',
                      isLoading: state is SignupLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.signup(
                            name: _nameController.text.trim(),
                            username: _usernameController.text.trim(),
                            phone: _phoneController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    const SocialLoginRow(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
