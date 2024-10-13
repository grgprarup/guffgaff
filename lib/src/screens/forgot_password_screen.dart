import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:guffgaff/src/constants.dart';
import 'package:guffgaff/src/services/authentication_service.dart';
import 'package:guffgaff/src/services/navigation_service.dart';
import 'package:guffgaff/src/services/toast_alert_service.dart';
import 'package:guffgaff/src/widgets/custom_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();

  late AuthenticationService _authenticationService;
  late ToastAlertService _toastAlertService;
  late NavigationService _navigationService;

  String? _email;

  @override
  void initState() {
    super.initState();
    _authenticationService = _getIt<AuthenticationService>();
    _toastAlertService = _getIt<ToastAlertService>();
    _navigationService = _getIt<NavigationService>();
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
            _forgotPasswordForm(),
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
            "Reset Password",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "Enter your email address to reset your password",
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

  Widget _forgotPasswordForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.20,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.02,
      ),
      child: Form(
        key: _forgotPasswordFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.1,
              labelText: "Email",
              validationRegEx: EMAIL_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cancelButton(),
                _sendResetLinkButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _cancelButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.2,
      child: MaterialButton(
        onPressed: () async {
                _navigationService.goBack();
                _navigationService.pushReplacementNamed('/login');
        },
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _sendResetLinkButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.4,
      child: MaterialButton(
        onPressed: () async {
          try {
            if (_forgotPasswordFormKey.currentState?.validate() ?? false) {
              _forgotPasswordFormKey.currentState?.save();
              bool sendResetLinkSuccess =
              await _authenticationService.sendPasswordResetEmail(_email!);

              if (sendResetLinkSuccess) {
                _toastAlertService.showToast(
                  text: 'Password reset link sent to $_email',
                  icon: Icons.check,
                );
                _navigationService.goBack();
                _navigationService.pushReplacementNamed('/login');
              }
            }
          } catch (e) {
            _toastAlertService.showToast(
              text: 'Failed to send reset link, Please try again!',
              icon: Icons.error,
            );
          }
        },
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          "Send Reset Link",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
