import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class _RegistrationScreenState
    extends State<RegistrationScreen> {

  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  bool acceptedTerms = false;

  void registerUser() {

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!acceptedTerms) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            'Please accept the terms and conditions',
          ),
        ),
      );

      return;
    }

    context
        .read<RegistrationBloc>()
        .add(

      RegisterUser(

        event:
            widget.event,

        name:
            nameController.text.trim(),

        email:
            emailController.text.trim(),

        phone:
            phoneController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<
        RegistrationBloc,
        RegistrationState>(

      listener: (context, state) {

        if (state
            is RegistrationSuccess) {

          // Show success dialog
          showDialog(
            context: context,
            barrierDismissible: false,

            builder: (context) {

              return AlertDialog(

                content: Column(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    // =================================
                    // SUCCESS ANIMATION
                    // =================================

                    TweenAnimationBuilder<double>(

                      tween:
                          Tween(
                        begin: 0.0,
                        end: 1.0,
                      ),

                      duration:
                          const Duration(
                        milliseconds: 600,
                      ),

                      curve:
                          Curves.elasticOut,

                      builder:
                          (
                        context,
                        value,
                        child,
                      ) {

                        return Transform.scale(

                          scale: value,

                          child: const Icon(
                            Icons.check_circle,

                            color:
                                Colors.green,

                            size: 80,
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      'Registration Successful!',

                      textAlign:
                          TextAlign.center,

                      style:
                          TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      state.message,

                      textAlign:
                          TextAlign.center,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width:
                          double.infinity,

                      child:
                          ElevatedButton(

                        onPressed: () {

                          Navigator.pop(
                            context,
                          );

                          Navigator.pop(
                            context,
                          );
                        },

                        child:
                            const Text(
                          'Done',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }


        if (state
            is RegistrationFailure) {

          ScaffoldMessenger.of(context)
              .showSnackBar(

            SnackBar(
              content:
                  Text(
                state.message,
              ),
            ),
          );
        }
      },


      child: Scaffold(

        appBar: AppBar(
          title:
              const Text(
            'Event Registration',
          ),
        ),

        body:
            SingleChildScrollView(

          padding:
              const EdgeInsets.all(20),

          child:
              Form(

            key:
                formKey,

            child:
                Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // =====================================
                // EVENT
                // =====================================

                const Text(
                  'Register for',

                  style:
                      TextStyle(
                    fontSize: 16,
                    color:
                        Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  widget.event.title,

                  style:
                      const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  '${widget.event.date} • '
                  '${widget.event.time}',
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  widget.event.location,
                ),

                const SizedBox(
                  height: 30,
                ),


                // =====================================
                // NAME
                // =====================================

                const Text(
                  'Full Name',

                  style:
                      TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                TextFormField(

                  controller:
                      nameController,

                  decoration:
                      const InputDecoration(

                    hintText:
                        'Enter your full name',

                    prefixIcon:
                        Icon(
                      Icons.person,
                    ),

                    border:
                        OutlineInputBorder(),
                  ),

                  validator:
                      (value) {

                    if (value == null ||
                        value.trim().isEmpty) {

                      return
                          'Please enter your name';
                    }

                    if (value
                            .trim()
                            .length <
                        3) {

                      return
                          'Name must contain at least 3 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),


                // =====================================
                // EMAIL
                // =====================================

                const Text(
                  'Email',

                  style:
                      TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                TextFormField(

                  controller:
                      emailController,

                  keyboardType:
                      TextInputType
                          .emailAddress,

                  decoration:
                      const InputDecoration(

                    hintText:
                        'Enter your email',

                    prefixIcon:
                        Icon(
                      Icons.email,
                    ),

                    border:
                        OutlineInputBorder(),
                  ),

                  validator:
                      (value) {

                    if (value == null ||
                        value.trim().isEmpty) {

                      return
                          'Please enter your email';
                    }

                    if (!value.contains('@')) {

                      return
                          'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),


                // =====================================
                // PHONE
                // =====================================

                const Text(
                  'Phone Number',

                  style:
                      TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                TextFormField(

                  controller:
                      phoneController,

                  keyboardType:
                      TextInputType.phone,

                  decoration:
                      const InputDecoration(

                    hintText:
                        'Enter your phone number',

                    prefixIcon:
                        Icon(
                      Icons.phone,
                    ),

                    border:
                        OutlineInputBorder(),
                  ),

                  validator:
                      (value) {

                    if (value == null ||
                        value.trim().isEmpty) {

                      return
                          'Please enter your phone number';
                    }

                    if (value
                            .trim()
                            .length !=
                        10) {

                      return
                          'Phone number must contain 10 digits';
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),


                // =====================================
                // TERMS
                // =====================================

                Row(

                  children: [

                    Checkbox(

                      value:
                          acceptedTerms,

                      onChanged:
                          (value) {

                        setState(() {

                          acceptedTerms =
                              value ??
                                  false;
                        });
                      },
                    ),

                    const Expanded(

                      child:
                          Text(
                        'I agree to the terms and conditions',
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),


                // =====================================
                // BUTTON
                // =====================================

                BlocBuilder<
                    RegistrationBloc,
                    RegistrationState>(

                  builder:
                      (context, state) {

                    final bool
                        isLoading =
                        state
                            is RegistrationLoading;

                    return AnimatedContainer(

                      duration:
                          const Duration(
                        milliseconds:
                            300,
                      ),

                      width:
                          double.infinity,

                      height:
                          isLoading
                              ? 60
                              : 55,

                      child:
                          ElevatedButton(

                        onPressed:
                            isLoading
                                ? null
                                : registerUser,

                        child:
                            AnimatedSwitcher(

                          duration:
                              const Duration(
                            milliseconds:
                                300,
                          ),

                          child:
                              isLoading

                                  ? const SizedBox(
                                      key:
                                          ValueKey(
                                        'loading',
                                      ),

                                      height:
                                          24,

                                      width:
                                          24,

                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth:
                                            2,
                                      ),
                                    )

                                  : const Text(
                                      'Register Now',

                                      key:
                                          ValueKey(
                                        'register',
                                      ),

                                      style:
                                          TextStyle(
                                        fontSize:
                                            17,
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
      ),
    );
  }
}