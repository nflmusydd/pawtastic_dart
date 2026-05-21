import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _supabase = Supabase.instance.client;
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFullProfile();
  }

  Future<void> _fetchFullProfile() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final data = await _supabase
          .from('profiles')
          .select('username, full_name, avatar_url, created_at')
          .eq('id', userId)
          .single();

      setState(() {
        _profileData = data;
        _isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) debugPrint("Error fetching profile: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthGuard(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar.centerTitle(
          context,
          blackTitle: context.t.account.index.profile.toTitleCase(),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile Header
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: (_profileData != null && _profileData?['avatar_url'] != null)
                                ? NetworkImage(_profileData!['avatar_url'])
                                : null,
                            child: (_profileData == null || _profileData?['avatar_url'] == null)
                                ? const Icon(Icons.person, size: 60, color: Colors.grey)
                                : null,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(252, 147, 3, 1.0),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit, color: Colors.white, size: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Information List
                    _buildInfoCard(
                      label: context.t.account.profile.username.toTitleCase(),
                      value: "@${_profileData?['username'] ?? '-'}",
                      icon: Icons.alternate_email_rounded,
                    ),
                    _buildInfoCard(
                      label: context.t.account.profile.full_name.toTitleCase(),
                      value: _profileData?['full_name'] ?? '-',
                      icon: Icons.person_outline_rounded,
                    ),
                    _buildInfoCard(
                      label: context.t.account.profile.joined_since.toTitleCase(),
                      value: _profileData?['created_at'] != null
                          ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_profileData!['created_at']))
                          // ? DateFormat('dd MMMM yyyy').format(DateTime.parse(_profileData!['created_at']))
                          : '-',
                      icon: Icons.calendar_today_rounded,
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),

                    // Security Section
                    GlobalMenuItem(
                      icon: Icons.lock_reset_rounded,
                      text: context.t.account.profile.change_password.toTitleCase(),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.changePassword);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 250, 250),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromRGBO(252, 147, 3, 1.0)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
