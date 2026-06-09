import 'package:flutter/material.dart';
import 'package:pawtastic/shared/utils/dialog_utils.dart';
import 'package:pawtastic/shared/utils/snackbar_utils.dart';
import 'package:pawtastic/services/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  void _showLanguageConfirmation(String language, String flag, String localeCode) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    DialogUtils.showConfirmationDialog(
      context: context,
      title: '${context.t.account.options.change_language.toTitleCase()}?',
      message: '${context.t.account.options.are_you_sure_you_want_to_change_the_language_to(flag: flag, language: language).ucfirst()}?',
      confirmText: context.t.account.options.yes_change.toTitleCase(),
      cancelText: context.t.common.cancel.toTitleCase(),
      onConfirm: () {
        localeProvider.setLocale(Locale(localeCode));
        
        SnackBarUtils.show(
          context,
          context.t.account.options.language_changed_to(language: language).ucfirst(),
          type: SnackBarType.info,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthGuard(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 250, 250),
        appBar: CustomAppBar.leftTitle(
          context,
          title: context.t.account.options.options.toTitleCase(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 20 + MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.account.options.language.toTitleCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 15),
              GlobalSelectionItem(
                title: 'English',
                leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
                isSelected: TranslationProvider.of(context).locale.languageCode == 'en',
                onTap: () => _showLanguageConfirmation('English', '🇺🇸', 'en'),
              ),
              GlobalSelectionItem(
                title: 'Indonesian',
                leading: const Text('🇮🇩', style: TextStyle(fontSize: 24)),
                isSelected: TranslationProvider.of(context).locale.languageCode == 'id',
                onTap: () => _showLanguageConfirmation('Indonesian', '🇮🇩', 'id'),
              ),
              
              const SizedBox(height: 30),
              Text(
                context.t.account.options.other_settings.toTitleCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 15),
              GlobalToggleItem(
                title: context.t.account.options.notifications.toTitleCase(),
                value: true,
                onChanged: (val) {},
              ),
              GlobalToggleItem(
                title: context.t.account.options.dark_mode.toTitleCase(),
                value: false,
                enabled: false,
                onChanged: (val) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
