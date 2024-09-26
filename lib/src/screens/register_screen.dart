import 'package:flutter/material.dart';
import 'package:guffgaff/src/screens/login_screen.dart';

import '../widgets/custom_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            _headerText(),
            _signUpForm(),
            _loginLink(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create an Account",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "It's quick and easy",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.70,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.05,
      ),
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profPicSelectionField(),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.1,
              labelText: "Full Name",
              onSaved: (value) {
                // TODO: Save the Full Name
              },
            ),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.1,
              labelText: "Email",
              onSaved: (value) {
                // TODO: Save the email
              },
            ),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.1,
              labelText: "Password",
              onSaved: (value) {
                // TODO: Save the password
              },
              obscureText: true,
            ),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.1,
              labelText: "Confirm Password",
              onSaved: (value) {
                // TODO: Save the confirm password
              },
              obscureText: true,
            ),
            _signUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _profPicSelectionField() {
    return GestureDetector(
      onTap: () {
        // TODO: Select profile picture
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
      ),
    );
  }

  Widget _signUpButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () {
          // TODO: Validate the form
        },
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          "SIGN UP",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _loginLink() {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Already have an account? "),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
