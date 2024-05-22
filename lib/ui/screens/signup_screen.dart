import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:plant_ecommerce/modules/auth/email%20signup/bloc/signup_bloc.dart';

import 'package:plant_ecommerce/modules/auth/email%20signup/email_signup_repository.dart';
import 'package:plant_ecommerce/ui/components/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final EmailSignUpRepository _emailSignUpRepository = EmailSignUpRepository();

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // final SignupBloc _signupBloc = BlocProvider.of<SignupBloc>(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              const Text(
                'Register Account',
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
                'Hello there, register to continue',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 28,
              ),
              CustomTextFormField(
                title: 'First Name',
                textEditingController: fnameController,
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                title: 'Last Name',
                textEditingController: lnameController,
              ),
              const SizedBox(
                height: 24,
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
              const SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                title: 'Confirm Password',
                isSecure: true,
              ),
              const SizedBox(
                height: 28,
              ),
              const Text('Placeholder for i agree to the terms and conditions'),
              const SizedBox(
                height: 24,
              ),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      context.read<SignupBloc>().add(SignUpRequested(
                          fname: fnameController.text,
                          lname: lnameController.text,
                          email: emailController.text,
                          password: passwordController.text));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromARGB(255, 75, 142, 75),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: state is SignupProcess
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Register',
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 0.5, color: Colors.grey),
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
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
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
                        side: const BorderSide(width: 0.5, color: Colors.grey),
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
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                  text: const TextSpan(
                    text: "Didn't have an account?",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Register',
                        style: TextStyle(
                          color: Color.fromARGB(255, 75, 142, 75),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
