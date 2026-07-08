import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  bool isProSelected = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 22),
            children: [
              _ProfileHeader(onBack: () => Navigator.of(context).pop()),
              const SizedBox(height: 24),
              const _ProfileCard(),
              const SizedBox(height: 14),
              _ModeSwitch(
                isProSelected: isProSelected,
                onChanged: (value) => setState(() => isProSelected = value),
              ),
              const SizedBox(height: 24),
              _ProfileMenuTile(
                icon: Icons.settings_outlined,
                title: 'Sozlamalar',
                onTap: () {},
              ),
              const SizedBox(height: 8),
              _ProfileMenuTile(
                icon: Icons.receipt_long_outlined,
                title: 'Kvitansiyalar',
                onTap: () {},
              ),
              const SizedBox(height: 8),
              _ProfileMenuTile(
                icon: Icons.description_outlined,
                title: "Umumiy ma'lumotlar",
                onTap: () {},
              ),
              const SizedBox(height: 8),
              _ProfileMenuTile(
                icon: Icons.headset_mic_outlined,
                title: "Bank bilan bog'lanish",
                onTap: () {},
              ),
              const SizedBox(height: 8),
              _ProfileMenuTile(
                icon: Icons.share_outlined,
                title: "Do'stlarni taklif qilish",
                onTap: () {},
              ),
              const SizedBox(height: 8),
              _ProfileMenuTile(
                icon: Icons.health_and_safety_outlined,
                title: 'Zararli ilovalarni aniqlash',
                showNewBadge: true,
                onTap: () {},
              ),
              const SizedBox(height: 8),
              _ProfileMenuTile(
                icon: Icons.logout,
                iconColor: const Color(0xFFE13E3E),
                title: 'Chiqish',
                onTap: () {},
              ),
              const SizedBox(height: 14),
              _ProfileMenuTile(
                icon: Icons.info_outline,
                iconColor: const Color(0xFF55B96C),
                title: 'Ommaviy oferta',
                centerContent: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onBack,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE7E8EA)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Color(0xFF9EA2A5),
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
          const Text(
            "Mening ma'lumotlarim",
            style: TextStyle(
              color: Color(0xFF1F2428),
              fontSize: 17,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 80),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E4E4), width: 1.1),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE0E3E3)),
            ),
            child: const Icon(Icons.person, color: Color(0xFF2C7044), size: 40),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AZIZXONXOJI QURBONOV',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF1F2428),
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_double_arrow_down,
                      color: Color(0xFF55B96C),
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'xazna mijozi',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF5C6265),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeSwitch extends StatelessWidget {
  const _ModeSwitch({required this.isProSelected, required this.onChanged});

  final bool isProSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ModeButton(
              icon: Icons.rocket_launch_outlined,
              title: 'xazna Pro',
              selected: isProSelected,
              onTap: () => onChanged(true),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Icon(Icons.swap_horiz, color: Color(0xFF55B96C), size: 28),
          ),
          Expanded(
            child: _ModeButton(
              icon: Icons.edit_outlined,
              title: 'xazna Lite',
              selected: !isProSelected,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: selected
                      ? const Color(0xFF55B96C)
                      : const Color(0xFF868B8E),
                  size: 19,
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1F2428),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  const _ProfileMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = const Color(0xFF8C9193),
    this.showNewBadge = false,
    this.centerContent = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;
  final bool showNewBadge;
  final bool centerContent;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: centerContent ? MainAxisSize.min : MainAxisSize.max,
      children: [
        SizedBox(width: 30, child: Icon(icon, color: iconColor, size: 24)),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF1F2428),
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
        ),
        if (showNewBadge) ...[const Spacer(), const _NewBadge()],
      ],
    );

    return Material(
      color: const Color(0xFFF4F6F4),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: centerContent ? Center(child: content) : content,
          ),
        ),
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE84850),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'NEW',
        style: TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
