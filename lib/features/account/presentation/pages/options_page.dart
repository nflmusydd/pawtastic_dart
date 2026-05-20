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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
      appBar: CustomAppBar.leftTitle(
        context,
        title: context.t.account.options.options.toTitleCase(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
            _buildLanguageCard('English', '🇺🇸', 'en', TranslationProvider.of(context).locale.languageCode == 'en', const Color.fromRGBO(252, 147, 3, 1.0)),
            _buildLanguageCard('Indonesian', '🇮🇩', 'id', TranslationProvider.of(context).locale.languageCode == 'id', const Color.fromRGBO(252, 147, 3, 1.0)),
            
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
            _buildToggleCard(context.t.account.options.notifications.toTitleCase(), true, const Color.fromRGBO(252, 147, 3, 1.0)),
            _buildToggleCard(context.t.account.options.dark_mode.toTitleCase(), false, const Color.fromRGBO(252, 147, 3, 1.0), enabled: false),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(String language, String flag, String localeCode, bool isSelected, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: isSelected
            ? Border.all(color: color, width: 2)
            : Border.all(color: Colors.transparent, width: 2),
      ),
      child: ListTile(
        onTap: () {
          if (!isSelected) {
            _showLanguageConfirmation(language, flag, localeCode);
          }
        },
        leading: Text(
          flag,
          style: const TextStyle(fontSize: 24),
        ),
        title: Text(
          language,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: color)
            : Icon(Icons.circle_outlined, color: Colors.grey.shade300),
      ),
    );
  }

  Widget _buildToggleCard(String title, bool value, Color color, {bool enabled = true}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: enabled ? Colors.black : Colors.grey,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: enabled ? (val) {} : null,
          activeColor: color,
        ),
      ),
    );
  }
}
