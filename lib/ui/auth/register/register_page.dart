import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';
import 'package:uep/ui/auth/widgets/role_dialog.dart';
import 'package:uep/ui/auth/widgets/social_auth_buttons.dart';
import 'package:uep/ui/auth/widgets/my_auth_text_field.dart';
import 'package:uep/ui/admin/pages/home/home_admin_screen.dart';

enum Role {
  student(["Student", 1]),
  teacher(["Teacher", 2]),
  admin(["Admin", 3]);

  final List description;
  const Role(this.description);
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  PhoneNumber phoneNumber = PhoneNumber();
  Role role = Role.student;

  void _onTapRegister() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "name": _nameController.text,
        "phone": phoneNumber.phoneNumber,
        "password": _passwordController.text,
        "password_confirmation": _confirmPasswordController.text,
        "role_id": role.description[1],
      };
      context.read<AuthenticationBloc>().add(AuthenticationSignUp(data: data));
    }
  }

  String? getErrorText(AuthenticationState state, String name) {
    if (state is AuthenticationFailure) {
      if (state.error[name] == null || state.error[name].isEmpty) {
        return null;
      } else {
        if (name == "phone") {}
        if (kDebugMode) {
          print(state.error[name][0].toString());
        }
        return state.error[name][0];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 25, top: 30),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    color: const Color(0xff3A89FF),
                  ),
                  const Text(
                    "Universal Education Platform",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff3A89FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: screenWidth * 0.90,
                height: screenHeight,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffC4CBD6).withOpacity(0.1),
                      blurRadius: 58,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PopupMenuButton<Role>(
                            icon: Text("Your role: ${role.description[0]}"),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: Role.student,
                                child: Text("Student"),
                              ),
                              const PopupMenuItem(
                                value: Role.teacher,
                                child: Text("Teacher"),
                              ),
                              const PopupMenuItem(
                                value: Role.admin,
                                child: Text("Admin"),
                              ),
                            ],
                            onSelected: (value) {
                              setState(() {
                                role = value;
                              });
                            },
                          )
                        ],
                      ),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Mobile Number",
                                  style: TextStyle(
                                    color: Color(0xff7D8592),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              InternationalPhoneNumberInput(
                                onInputChanged: (value) {
                                  phoneNumber = value;
                                },
                                inputBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                validator: (value) {
                                  return getErrorText(state, "phone");
                                },
                              ),
                              const SizedBox(height: 15),
                              MyAuthTextField(
                                controller: _nameController,
                                // validator: Validator.validateName,
                                title: "Name",
                                hintText: "Pavel Durov",
                                errorText: getErrorText(state, "name"),
                                textInputType: TextInputType.name,
                              ),
                              const SizedBox(height: 15),
                              MyAuthTextField(
                                controller: _passwordController,
                                // validator: Validator.validatePassword,
                                title: "Password",
                                hintText: "••••••••",
                                errorText: getErrorText(state, "password"),
                                textInputType: TextInputType.visiblePassword,
                                isObscurely: true,
                              ),
                              const SizedBox(height: 15),
                              MyAuthTextField(
                                controller: _confirmPasswordController,
                                // validator: (value) =>
                                //     Validator.validateConfirmPassword(
                                //         value, _passwordController.text),
                                title: "Password Confirmation",
                                hintText: "••••••••",
                                errorText: getErrorText(
                                    state, "password_confirmation"),
                                textInputType: TextInputType.visiblePassword,
                                isObscurely: true,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if (state is AuthenticationAuthenticated) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeAdminScreen(),
                              ),
                            );
                          }
                        },
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: _onTapRegister,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xff3F8CFF),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff3F8CFF).withOpacity(0.5),
                                  blurRadius: 25,
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.navigate_next_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialAuthButtons(
                            imagePath: "assets/google.svg",
                            onTap: () async {
                              // int? roleId = await showRoleDiolog();
                              // ignore: use_build_context_synchronously
                              // context.read<AuthenticationBloc>().add(
                              //       SocialLoginEvent(
                              //         type: SocialLoginTypes.google,
                              //         roleId: roleId,
                              //       ),
                              //     );
                            },
                          ),
                          const SizedBox(width: 15),
                          SocialAuthButtons(
                            imagePath: "assets/facebook.svg",
                            onTap: () async {
                              // int? roleId = await showRoleDiolog();
                              // ignore: use_build_context_synchronously
                              // context.read<AuthenticationBloc>().add(
                              //       SocialLoginEvent(
                              //         type: SocialLoginTypes.facebook,
                              //         roleId: roleId,
                              //       ),
                              //     );
                            },
                          ),
                          const SizedBox(width: 15),
                          SocialAuthButtons(
                            imagePath: "assets/github.svg",
                            onTap: () async {
                              // int? roleId = await showRoleDiolog();
                              // ignore: use_build_context_synchronously
                              // context.read<AuthenticationBloc>().add(
                              //       SocialLoginEvent(
                              //         type: SocialLoginTypes.github,
                              //         roleId: roleId,
                              //       ),
                              //     );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: "Already have an account?",
                          style: const TextStyle(
                            color: Color(0xff7D8592),
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(
                              text: " Sign In",
                              style: const TextStyle(
                                color: Color(0xff3F8CFF),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> showRoleDiolog() async {
    return await showDialog(
      context: context,
      builder: (ctx) => const RoleDialog(),
    );
  }
}
