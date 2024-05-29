import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plant_ecommerce/modules/auth/email%20login/bloc/login_bloc.dart';
import 'package:plant_ecommerce/modules/auth/google%20auth/repository/google_sign_in_repository.dart';
import 'package:plant_ecommerce/ui/components/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleSignInRepository _googleSignInRepository =
      GoogleSignInRepository();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      context
          .read<LoginBloc>()
          .add(LoginAuthenticationRequested(email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginAuthenticationSuccess || state is LoginSuccess) {
              context.go('/');
            } else if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.loginFailedMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go('/');
            } else if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.loginFailedMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            var user = snapshot.data;
            if (!snapshot.hasError) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 26),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          // color: Colors.red,
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            child: Image.asset(
                              'assets/images/Logo-Dark.png',
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'to',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' PLANT',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 75, 142, 75),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Text(
                          'Hello there, login to continue',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        CustomTextFormField(
                          title: 'Email Address',
                          textEditingController: emailController,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextFormField(
                          title: 'Password',
                          isSecure: true,
                          textEditingController: passwordController,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  alignment: Alignment.centerRight),
                              child: const Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 75, 142, 75),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is LoggingIn ? null : login,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 75, 142, 75),
                                minimumSize: const Size(double.infinity, 60),
                              ),
                              child: state is LoggingIn
                                  ? const CircularProgressIndicator.adaptive()
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            'Or continue with social account',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: SvgPicture.asset(
                                  'assets/vectors/google.svg',
                                  height: 24,
                                ),
                                onPressed: () async {
                                  await _googleSignInRepository
                                      .signInWithGoogle();
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 0.5, color: Colors.grey),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  minimumSize: const Size(double.infinity, 60),
                                ),
                                label: const Text(
                                  ' Google',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: SvgPicture.asset(
                                  'assets/vectors/facebook.svg',
                                  height: 28,
                                ),
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 0.5, color: Colors.grey),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  minimumSize: const Size(double.infinity, 60),
                                ),
                                label: const Text(
                                  ' Facebook',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Didn't have an account?",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Register',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 75, 142, 75),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.go('/login/signup');
                                    },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
