import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

class UnauthenticatedPage extends StatelessWidget {
  final String? message;
  final bool isSeller;

  const UnauthenticatedPage({
    super.key,
    this.message,
    this.isSeller = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_person_rounded,
                size: 100,
                color: Color.fromRGBO(252, 147, 3, 1.0),
              ),
              const SizedBox(height: 30),
              Text(
                context.t.common.login_required.toTitleCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                message ?? (isSeller 
                  ? "${context.t.common.please_login_as_a_seller_to_access_this_page}."
                  : "${context.t.common.please_login_to_access_this_page}."),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                label: "${context.t.common.login.toTitleCase()} ${context.t.common.now.toTitleCase()}",
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    isSeller ? AppRoutes.loginSeller : AppRoutes.login, 
                    (route) => false,
                  );
                },
              ),
            //   const SizedBox(height: 16),
            //   CustomTextButton(
            //     text: "Back to Home",
            //     onPressed: () {
            //       Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
            //     },
            //     textStyle: const TextStyle(
            //       color: Colors.grey,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            ],
          ),
        ),
      ),
    );
  }
}
