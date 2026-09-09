import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/skeleton_loading.dart';
import '../../../routes/route_names.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  // Validation error states
  bool _emailHasError = false;
  bool _passwordHasError = false;
  String? _errorMessage;
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

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    final bool isEmailEmpty = email.isEmpty;
    final bool isPasswordEmpty = password.isEmpty;

    // 1. If credentials have not been entered at all
    if (isEmailEmpty && isPasswordEmpty) {
      setState(() {
        _emailHasError = true;
        _passwordHasError = true;
        _errorMessage = 'Please enter your credentials';
      });
      return;
    }

    if (isEmailEmpty) {
      setState(() {
        _emailHasError = true;
        _passwordHasError = false;
        _errorMessage = 'Please enter your email';
      });
      return;
    }

    if (isPasswordEmpty) {
      setState(() {
        _emailHasError = false;
        _passwordHasError = true;
        _errorMessage = 'Please enter your password';
      });
      return;
    }

    // 2. Format / validity checks
    final bool isEmailValid =
        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    final bool isPasswordValid = password.length >= 6;

    if (!isEmailValid && !isPasswordValid) {
      setState(() {
        _emailHasError = true;
        _passwordHasError = true;
        _errorMessage = 'Please enter valid credentials';
      });
      return;
    }

    if (!isEmailValid) {
      setState(() {
        _emailHasError = true;
        _passwordHasError = false;
        _errorMessage = 'Please enter a valid email address';
      });
      return;
    }

    if (!isPasswordValid) {
      setState(() {
        _emailHasError = false;
        _passwordHasError = true;
        _errorMessage = 'Password must be at least 6 characters';
      });
      return;
    }

    // 3. Clear errors and proceed
    setState(() {
      _emailHasError = false;
      _passwordHasError = false;
      _errorMessage = null;
    });

    // Navigate to the main event list screen
    Navigator.pushReplacementNamed(
      context,
      RouteNames.eventList,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const SignInSkeleton()
          : Stack(
              children: [
          // =========================================================
          // Layer 1: Fixed Background Graphic with 3D Kids & Wavy Cut
          // =========================================================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.42,
            child: Image.asset(
              'assets/images/login-fullscreen.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          // =========================================================
          // Layer 2: Top Header Controls (Language Pill & Logo)
          // =========================================================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Top-right Knotnex white logo
                    Image.asset(
                      'assets/logo/logo-knotnex-white.png',
                      height: 34,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // =========================================================
          // Layer 3: Form Content Below Wavy Header
          // =========================================================
          Positioned.fill(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.38,
                  left: 24.0,
                  right: 24.0,
                  bottom: 24.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // "LOGIN" Title
                      const Center(
                        child: Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF6336EB),
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            fontFamily: 'Google Sans',
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Email Label
                      const Text(
                        'Email',
                        style: TextStyle(
                          color: Color(0xFF6336EB),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Email Input Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          if (_emailHasError) {
                            final trimmed = value.trim();
                            setState(() {
                              _emailHasError = trimmed.isEmpty ||
                                  !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                      .hasMatch(trimmed);
                              if (!_emailHasError && !_passwordHasError) {
                                _errorMessage = null;
                              }
                            });
                          }
                        },
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF1A1A2E),
                          fontFamily: 'Google Sans',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter email or username',
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: _emailHasError
                                  ? AppColors.error
                                  : const Color(0xFFCFC1F9),
                              width: _emailHasError ? 1.5 : 1.2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: _emailHasError
                                  ? AppColors.error
                                  : const Color(0xFFCFC1F9),
                              width: _emailHasError ? 1.5 : 1.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: _emailHasError
                                  ? AppColors.error
                                  : const Color(0xFF6336EB),
                              width: _emailHasError ? 2.0 : 1.8,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Password Label
                      const Text(
                        'Password',
                        style: TextStyle(
                          color: Color(0xFF6336EB),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Password Input Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        onChanged: (value) {
                          if (_passwordHasError) {
                            setState(() {
                              _passwordHasError = value.length < 6;
                              if (!_emailHasError && !_passwordHasError) {
                                _errorMessage = null;
                              }
                            });
                          }
                        },
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF1A1A2E),
                          fontFamily: 'Google Sans',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: _passwordHasError
                                  ? AppColors.error
                                  : const Color(0xFFCFC1F9),
                              width: _passwordHasError ? 1.5 : 1.2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: _passwordHasError
                                  ? AppColors.error
                                  : const Color(0xFFCFC1F9),
                              width: _passwordHasError ? 1.5 : 1.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: _passwordHasError
                                  ? AppColors.error
                                  : const Color(0xFF6336EB),
                              width: _passwordHasError ? 2.0 : 1.8,
                            ),
                          ),
                        ),
                      ),

                      // Static single-line error message container above the login button
                      const SizedBox(height: 8),
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

                      // "Sign In" Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _onSignIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6336EB),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
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

                      const SizedBox(height: 18),

                      // "Forget Password?"
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Password reset link will be sent to your email.'),
                              ),
                            );
                          },
                          child: const Text(
                            'Forget Password?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF4B5563),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Google Sans',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // "Don't have an account? Create Account"
                      Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Don’t have an account? ",
                                style: TextStyle(
                                  color: Color(0xFF4B5563),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Google Sans',
                                ),
                              ),
                              TextSpan(
                                text: 'Create Account',
                                style: const TextStyle(
                                  color: Color(0xFF6336EB),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Google Sans',
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.signUp,
                                    );
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 22),

                      // "By continuing, you agree to our Terms of Service and Privacy Policy."
                      Center(
                        child: Text.rich(
                          TextSpan(
                            children: const [
                              TextSpan(
                                text: 'By continuing, you agree to our ',
                                style: TextStyle(
                                  color: Color(0xFF4B5563),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Google Sans',
                                ),
                              ),
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: Color(0xFF6336EB),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Google Sans',
                                ),
                              ),
                              TextSpan(
                                text: ' and\n',
                                style: TextStyle(
                                  color: Color(0xFF4B5563),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Google Sans',
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: TextStyle(
                                  color: Color(0xFF6336EB),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Google Sans',
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
