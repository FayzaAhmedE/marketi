import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../manager/forgot_password_cubit.dart';
import '../manager/forgot_password_state.dart';
import 'create_new_password_view.dart';

class VerifyCodeView extends StatefulWidget {
  final ForgotPasswordCubit cubit;
  final String contact;

  const VerifyCodeView({super.key, required this.cubit, required this.contact});

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  int _secondsLeft = 46;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsLeft = 46;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  String get _code => _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
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
              if (state is CodeVerified) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPasswordView(cubit: widget.cubit),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Verification Code',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Please enter the 4 digit code sent to: ${widget.contact}'),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 56,
                        height: 56,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              _focusNodes[index + 1].requestFocus();
                            }
                            if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Verify Code',
                    isLoading: state is ForgotPasswordLoading,
                    onPressed: () {
                      if (_code.length == 4) {
                        widget.cubit.verifyCode(_code);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('اكتبي الكود كامل (4 أرقام)')),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: _secondsLeft > 0
                        ? Text('00:${_secondsLeft.toString().padLeft(2, '0')}')
                        : TextButton(
                            onPressed: () {
                              widget.cubit.sendCode(widget.contact, 'forgot_password');
                              _startTimer();
                            },
                            child: const Text('Resend Code'),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
