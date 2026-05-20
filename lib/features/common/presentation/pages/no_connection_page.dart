import 'package:flutter/material.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 100,
                color: const Color.fromRGBO(252, 147, 3, 1.0),
              ),
              const SizedBox(height: 30),
              Text(
                context.t.no_connection.connection_failed.toTitleCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                context.t.no_connection.we_could_not_reach_the_server_please_try_again_later.ucfirst(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black54,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 50),
              PrimaryButton(
                label: context.t.no_connection.try_again.toTitleCase(),
                width: 200,
                onPressed: () {
                  context.read<UserProvider>().retry();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
