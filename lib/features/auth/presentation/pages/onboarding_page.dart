import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/services/locale_provider.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "images/starting_page.png",
                  width: 300.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
            // Main Heading
                Text(
                  "RUFF!\n${context.t.auth.onboarding.welcome_to_pawtastic.toTitleCase()}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 30),
            // Subtitle
                Text(
                  context.t.auth.onboarding.one_app_for_all_of_your_pet_equipment.ucfirst(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    height: 24 / 16,
                  ),
                ),
                const SizedBox(height: 100),
            // Get Started Button
                CustomTextButton(
                  text: context.t.auth.onboarding.get_started.toTitleCase(),
                  route: AppRoutes.signup,
                  textStyle: const TextStyle(
                    color: Colors.orange,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10.0),
            // Login Button
                CustomTextButton(
                  text: context.t.auth.onboarding.login.toTitleCase(),
                  route: AppRoutes.login,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 12,
            child: PopupMenuButton<AppLocale>(
              onSelected: (locale) {
                context.read<LocaleProvider>().setLocale(locale.flutterLocale);
              },
              itemBuilder: (context) => [
                for (final l in AppLocale.values)
                  PopupMenuItem(
                    value: l,
                    child: Text(l.languageCode.toUpperCase()),
                  ),
              ],
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  LocaleSettings.currentLocale.languageCode.toUpperCase(),
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
