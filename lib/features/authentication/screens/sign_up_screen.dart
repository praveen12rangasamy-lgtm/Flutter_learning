import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/skeleton_loading.dart';
import '../../../routes/route_names.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;
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

  // Validation error states
  bool _nameHasError = false;
  bool _emailHasError = false;
  bool _passwordHasError = false;
  bool _confirmPasswordHasError = false;
  String? _errorMessage;

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onCreateAccount() {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    final bool isNameEmpty = name.isEmpty;
    final bool isEmailEmpty = email.isEmpty;
    final bool isPasswordEmpty = password.isEmpty;
    final bool isConfirmEmpty = confirmPassword.isEmpty;

    // Check empty fields
    if (isNameEmpty && isEmailEmpty && isPasswordEmpty && isConfirmEmpty) {
      setState(() {
        _nameHasError = true;
        _emailHasError = true;
        _passwordHasError = true;
        _confirmPasswordHasError = true;
        _errorMessage = 'Please enter your credentials';
      });
      return;
    }

    if (isNameEmpty) {
      setState(() {
        _nameHasError = true;
        _errorMessage = 'Please enter your full name';
      });
      return;
    }

    if (name.length < 3) {
      setState(() {
        _nameHasError = true;
        _errorMessage = 'Name must be at least 3 characters';
      });
      return;
    }

    final bool isEmailValid =
        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    if (isEmailEmpty || !isEmailValid) {
      setState(() {
        _emailHasError = true;
        _errorMessage = 'Please enter a valid email address';
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        _passwordHasError = true;
        _errorMessage = 'Password must be at least 6 characters';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _confirmPasswordHasError = true;
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    if (!_acceptedTerms) {
      setState(() {
        _errorMessage = 'Please agree to the Terms and Privacy Policy';
      });
      return;
    }

    // Success: clear errors
    setState(() {
      _nameHasError = false;
      _emailHasError = false;
      _passwordHasError = false;
      _confirmPasswordHasError = false;
      _errorMessage = null;
    });

    // Show success confirmation dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.primary,
                    size: 56,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Account Created!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: 'Google Sans',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your account has been successfully created. You can now explore upcoming events.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                    fontFamily: 'Google Sans',
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      Navigator.pushReplacementNamed(
                        context,
                        RouteNames.eventList,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Google Sans',
                      ),
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

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required bool hasError,
    required ValueChanged<String> onChanged,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Google Sans',
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF1A1A2E),
            fontFamily: 'Google Sans',
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Google Sans',
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : const Color(0xFFCFC1F9),
                width: hasError ? 1.5 : 1.2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : const Color(0xFFCFC1F9),
                width: hasError ? 1.5 : 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : const Color(0xFF6336EB),
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
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Create Account',
        ),
        centerTitle: false,
      ),
      body: _isLoading
          ? const SignUpSkeleton()
          : SafeArea(
              child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Full Name field
              _buildField(
                label: 'Full Name',
                controller: _nameController,
                hintText: 'Enter your full name',
                hasError: _nameHasError,
                onChanged: (val) {
                  if (_nameHasError) {
                    setState(() {
                      _nameHasError = val.trim().length < 3;
                      if (!_nameHasError &&
                          !_emailHasError &&
                          !_passwordHasError &&
                          !_confirmPasswordHasError) {
                        _errorMessage = null;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Email field
              _buildField(
                label: 'Email',
                controller: _emailController,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                hasError: _emailHasError,
                onChanged: (val) {
                  if (_emailHasError) {
                    final trimmed = val.trim();
                    setState(() {
                      _emailHasError = trimmed.isEmpty ||
                          !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                              .hasMatch(trimmed);
                      if (!_nameHasError &&
                          !_emailHasError &&
                          !_passwordHasError &&
                          !_confirmPasswordHasError) {
                        _errorMessage = null;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Password field
              _buildField(
                label: 'Password',
                controller: _passwordController,
                hintText: 'Enter password (min 6 characters)',
                obscureText: _obscurePassword,
                hasError: _passwordHasError,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF9CA3AF),
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                onChanged: (val) {
                  if (_passwordHasError) {
                    setState(() {
                      _passwordHasError = val.length < 6;
                      if (!_nameHasError &&
                          !_emailHasError &&
                          !_passwordHasError &&
                          !_confirmPasswordHasError) {
                        _errorMessage = null;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Confirm Password field
              _buildField(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                hintText: 'Re-enter your password',
                obscureText: _obscureConfirmPassword,
                hasError: _confirmPasswordHasError,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF9CA3AF),
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                onChanged: (val) {
                  if (_confirmPasswordHasError) {
                    setState(() {
                      _confirmPasswordHasError =
                          val != _passwordController.text;
                      if (!_nameHasError &&
                          !_emailHasError &&
                          !_passwordHasError &&
                          !_confirmPasswordHasError) {
                        _errorMessage = null;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              // Terms checkbox
              Row(
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setState(() {
                        _acceptedTerms = val ?? false;
                        if (_acceptedTerms &&
                            !_nameHasError &&
                            !_emailHasError &&
                            !_passwordHasError &&
                            !_confirmPasswordHasError) {
                          _errorMessage = null;
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _acceptedTerms = !_acceptedTerms;
                          if (_acceptedTerms &&
                              !_nameHasError &&
                              !_emailHasError &&
                              !_passwordHasError &&
                              !_confirmPasswordHasError) {
                            _errorMessage = null;
                          }
                        });
                      },
                      child: const Text(
                        'I agree to the Terms of Service and Privacy Policy',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4B5563),
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Static single-line error message container above the button
              const SizedBox(height: 6),
              Container(
                height: 22,
                alignment: Alignment.centerLeft,
                child: Visibility(
                  visible: _errorMessage != null,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Text(
                    _errorMessage ?? ' ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // "Create Account" Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onCreateAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6336EB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // "Already have an account? Sign In"
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: Color(0xFF4B5563),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                      TextSpan(
                        text: 'Sign In',
                        style: const TextStyle(
                          color: Color(0xFF6336EB),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Google Sans',
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
