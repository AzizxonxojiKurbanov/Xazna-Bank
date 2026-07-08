import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xazna_bank/presentation/tabs/services/data/services_mock_data.dart';
import 'package:xazna_bank/presentation/tabs/services/settings/settings_screen.dart';
import 'package:xazna_bank/presentation/tabs/services/widgets/service_list_tile.dart';
import 'package:xazna_bank/presentation/tabs/services/widgets/services_profile_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Color(0xFFF7F9F6),
        body: SafeArea(child: _ServicesBody()),
      ),
    );
  }
}

class _ServicesBody extends StatelessWidget {
  const _ServicesBody();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(14, 18, 14, 0),
          sliver: SliverToBoxAdapter(child: _ServicesHeader()),
        ),
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(14, 24, 14, 0),
          sliver: SliverToBoxAdapter(
            child: ServicesProfileCard(
              fullName: 'AZIZXONXOJI QURBONOV',
              subtitle: 'xazna mijozi',
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(14, 22, 14, 10),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Xizmatlar',
              style: TextStyle(
                color: Color(0xFF1F2428),
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 18),
          sliver: SliverList.separated(
            itemCount: serviceMenuItems.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return ServiceListTile(item: serviceMenuItems[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _ServicesHeader extends StatelessWidget {
  const _ServicesHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Image.asset(
            'assets/images/xazna_logo.png',
            height: 29,
            alignment: Alignment.centerLeft,
            fit: BoxFit.contain,
          ),
        ),
        IconButton(
          tooltip: 'Sozlamalar',
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
          },
          icon: const Icon(Icons.settings_outlined),
          color: const Color(0xFF4E5558),
          iconSize: 26,
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}
