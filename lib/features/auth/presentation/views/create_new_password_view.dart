import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/forgot_password_cubit.dart';
import '../manager/forgot_password_state.dart';
import 'congratulations_view.dart';

class CreateNewPasswordView extends StatefulWidget {
  final ForgotPasswordCubit cubit;

  const CreateNewPasswordView({super.key, required this.cubit});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            bloc: widget.cubit,
            listener: (context, state) {
              if (state is ForgotPasswordError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is PasswordResetSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const CongratulationsView()),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create New Password',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('New password must be different from last password'),
                    const SizedBox(height: 24),
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
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'كلمة السر لازم تكون 6 حروف على الأقل';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'الباسورد مش متطابق';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Save Password',
                      isLoading: state is ForgotPasswordLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.cubit.resetPassword(_passwordController.text);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
