import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:guffgaff/src/constants.dart';
import 'package:guffgaff/src/models/user_profile.dart';
import 'package:guffgaff/src/services/authentication_service.dart';
import 'package:guffgaff/src/services/database_service.dart';
import 'package:guffgaff/src/services/media_service.dart';
import 'package:guffgaff/src/services/navigation_service.dart';
import 'package:guffgaff/src/services/storage_service.dart';
import 'package:guffgaff/src/services/toast_alert_service.dart';
import 'package:guffgaff/src/widgets/custom_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  late AuthenticationService _authenticationService;
  late MediaService _mediaService;
  late NavigationService _navigationService;
  late StorageService _storageService;
  late DatabaseService _databaseService;
  late ToastAlertService _toastAlertService;

  String? fullName, email, password, confirmPassword;
  File? selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _authenticationService = _getIt<AuthenticationService>();
    _mediaService = _getIt<MediaService>();
    _navigationService = _getIt<NavigationService>();
    _storageService = _getIt<StorageService>();
    _databaseService = _getIt<DatabaseService>();
    _toastAlertService = _getIt<ToastAlertService>();
  }

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
            if (!isLoading) _signUpForm(),
            if (!isLoading) _loginLink(),
            if (isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
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
        key: _signUpFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profPicSelectionField(),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.1,
              labelText: "Full Name",
              validationRegEx: NAME_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  fullName = value;
                });
              },
            ),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.1,
              labelText: "Email",
              validationRegEx: EMAIL_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.1,
              labelText: "Password",
              validationRegEx: PASSWORD_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
            ),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.1,
              labelText: "Confirm Password",
              validationRegEx: PASSWORD_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  confirmPassword = value;
                });
                // TODO: Validate the password and confirmPassword
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
      onTap: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : AssetImage(PROF_PIC_PLACEHOLDER) as ImageProvider,
      ),
    );
  }

  Widget _signUpButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
            if (_signUpFormKey.currentState?.validate() ?? false) {
              _signUpFormKey.currentState?.save();
              bool signUpSuccess =
                  await _authenticationService.signUp(email!, password!);
              if (signUpSuccess) {
                String? profPicURL = await _storageService.uploadUserProfPic(
                  file: selectedImage!,
                  uid: _authenticationService.user!.uid,
                );
                if (profPicURL != null) {
                  await _databaseService.createUserProfile(
                    userProfile: UserProfile(
                      userId: _authenticationService.user!.uid,
                      fullName: fullName!,
                      profPicURL: profPicURL,
                    ),
                  );
                  _toastAlertService.showToast(
                    text: 'User registered successfully',
                    icon: Icons.check,
                  );
                  _navigationService.goBack();
                  _navigationService.pushReplacementNamed('/home');
                } else {
                  throw Exception('Uploading user profile picture failed.');
                }
              } else {
                throw Exception('User registration failed.');
              }
            }
          } catch (e) {
            _toastAlertService.showToast(
              text: 'Failed to register, Please try again!',
              icon: Icons.error,
            );
          }
          setState(() {
            isLoading = false;
          });
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
              _navigationService.goBack();
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
