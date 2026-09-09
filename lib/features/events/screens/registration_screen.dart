import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_menu_actions.dart';
import '../../../core/widgets/skeleton_loading.dart';
import '../blocs/registration_bloc.dart';
import '../models/event.dart';

class RegistrationScreen extends StatefulWidget {
  final Event event;

  const RegistrationScreen({
    super.key,
    required this.event,
  });

  @override
  State<RegistrationScreen> createState() {
    return _RegistrationScreenState();
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool acceptedTerms = false;
  bool _isLoading = true;
  Timer? _loadingTimer;

  @override
  void initState() {
    super.initState();
    _loadingTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  // Form field error states
  bool nameHasError = false;
  bool emailHasError = false;
  bool phoneHasError = false;
  bool termsHasError = false;
  String? singleErrorMessage;

  void registerUser() {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();

    final bool isNameValid = name.length >= 3;
    final bool isEmailValid = email.isNotEmpty &&
        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    final bool isPhoneValid =
        phone.isNotEmpty && RegExp(r'^\d{10}$').hasMatch(phone);
    final bool isTermsValid = acceptedTerms;

    setState(() {
      nameHasError = !isNameValid;
      emailHasError = !isEmailValid;
      phoneHasError = !isPhoneValid;
      termsHasError = !isTermsValid;

      if (!isNameValid || !isEmailValid || !isPhoneValid) {
        singleErrorMessage = 'Please enter valid details';
      } else if (!isTermsValid) {
        singleErrorMessage = 'Please accept the terms and conditions';
      } else {
        singleErrorMessage = null;
      }
    });

    if (!isNameValid || !isEmailValid || !isPhoneValid || !isTermsValid) {
      return;
    }

    context.read<RegistrationBloc>().add(
          RegisterUser(
            event: widget.event,
            name: name,
            email: email,
            phone: phone,
          ),
        );
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool hasError,
    required ValueChanged<String> onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: AppColors.inputIconColor,
            ),
            filled: true,
            fillColor: AppColors.inputFill,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : AppColors.inputBorder,
                width: hasError ? 1.5 : 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : AppColors.primary,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationSuccess) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween(
                          begin: 0.0,
                          end: 1.0,
                        ),
                        duration: const Duration(
                          milliseconds: 600,
                        ),
                        curve: Curves.elasticOut,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                                size: 68,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Registration Successful!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (state is RegistrationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
              ),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 44,
          titleSpacing: 4,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Event Registration',
          ),
          centerTitle: false,
          actions: const [
            AppMenuActions(),
          ],
        ),
        body: _isLoading
            ? const RegistrationSkeleton()
            : SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Preview Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFECE7FF),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Registering for',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.event.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 15,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${widget.event.date} • ${widget.event.time}',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.event.location,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Name field
              _buildTextField(
                label: 'Full Name',
                controller: nameController,
                hintText: 'Enter your full name',
                icon: Icons.person_outline,
                hasError: nameHasError,
                onChanged: (val) {
                  if (nameHasError) {
                    setState(() {
                      nameHasError = val.trim().length < 3;
                      if (!nameHasError && !emailHasError && !phoneHasError) {
                        if (!acceptedTerms) {
                          singleErrorMessage =
                              'Please accept the terms and conditions';
                        } else {
                          singleErrorMessage = null;
                        }
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 18),

              // Email field
              _buildTextField(
                label: 'Email Address',
                controller: emailController,
                hintText: 'Enter your email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                hasError: emailHasError,
                onChanged: (val) {
                  if (emailHasError) {
                    final trimmed = val.trim();
                    setState(() {
                      emailHasError = trimmed.isEmpty ||
                          !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                              .hasMatch(trimmed);
                      if (!nameHasError && !emailHasError && !phoneHasError) {
                        if (!acceptedTerms) {
                          singleErrorMessage =
                              'Please accept the terms and conditions';
                        } else {
                          singleErrorMessage = null;
                        }
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 18),

              // Phone field
              _buildTextField(
                label: 'Phone Number',
                controller: phoneController,
                hintText: 'Enter your phone number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                hasError: phoneHasError,
                onChanged: (val) {
                  if (phoneHasError) {
                    final trimmed = val.trim();
                    setState(() {
                      phoneHasError = trimmed.isEmpty ||
                          !RegExp(r'^\d{10}$').hasMatch(trimmed);
                      if (!nameHasError && !emailHasError && !phoneHasError) {
                        if (!acceptedTerms) {
                          singleErrorMessage =
                              'Please accept the terms and conditions';
                        } else {
                          singleErrorMessage = null;
                        }
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 18),

              // Terms checkbox
              Row(
                children: [
                  Checkbox(
                    value: acceptedTerms,
                    onChanged: (value) {
                      setState(() {
                        acceptedTerms = value ?? false;
                        if (acceptedTerms) {
                          termsHasError = false;
                          if (!nameHasError &&
                              !emailHasError &&
                              !phoneHasError) {
                            singleErrorMessage = null;
                          }
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          acceptedTerms = !acceptedTerms;
                          if (acceptedTerms) {
                            termsHasError = false;
                            if (!nameHasError &&
                                !emailHasError &&
                                !phoneHasError) {
                              singleErrorMessage = null;
                            }
                          }
                        });
                      },
                      child: const Text(
                        'I agree to the terms and conditions',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Static error message area above the button (button position never shifts)
              Container(
                height: 28,
                alignment: Alignment.centerLeft,
                child: Visibility(
                  visible: singleErrorMessage != null,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Text(
                    singleErrorMessage ?? ' ',
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Submit button
              BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  final bool isLoading = state is RegistrationLoading;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : registerUser,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isLoading
                            ? const SizedBox(
                                key: ValueKey('loading'),
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Register Now',
                                key: ValueKey('register'),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
