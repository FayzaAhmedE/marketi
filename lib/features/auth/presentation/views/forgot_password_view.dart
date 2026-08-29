import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/forgot_password_cubit.dart';
import '../manager/forgot_password_state.dart';
import 'verify_code_view.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final cubit = ForgotPasswordCubit();
  final _contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPhone = false;

  @override
  void dispose() {
    cubit.close();
    _contactController.dispose();
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
            bloc: cubit,
            listener: (context, state) {
              if (state is ForgotPasswordError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is CodeSent) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        VerifyCodeView(cubit: cubit, contact: cubit.contact),
                  ),
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
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isPhone
                          ? 'Please enter your phone number to receive a verification code'
                          : 'Please enter your email address to receive a verification code',
                      style: const TextStyle(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: _contactController,
                      label: _isPhone ? 'Phone Number' : 'Email',
                      hintText: _isPhone ? 'Phone Number' : 'You@gmail.com',
                      keyboardType:
                          _isPhone ? TextInputType.phone : TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'الحقل ده مطلوب';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Send Code',
                      isLoading: state is ForgotPasswordLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.sendCode(_contactController.text.trim());
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isPhone = !_isPhone;
                            _contactController.clear();
                          });
                        },
                        child: const Text('Try Another Way'),
                      ),
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
