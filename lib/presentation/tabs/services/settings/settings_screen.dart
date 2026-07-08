import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguageCode = 'uz';
  String selectedAppearanceCode = 'system';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9F6),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _BackButton(
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const Text(
                      'Sozlamalar',
                      style: TextStyle(
                        color: Color(0xFF1F2428),
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.shield_outlined,
                      title: 'Xavfsizlik',
                      onTap: () {},
                    ),
                    const SizedBox(height: 9),
                    _SettingsTile(
                      icon: Icons.notifications_none,
                      title: 'Xabarnoma',
                      onTap: () {},
                    ),
                    const SizedBox(height: 9),
                    _SettingsTile(
                      icon: Icons.view_agenda_outlined,
                      title: 'Vidjet sozlamalari',
                      onTap: () {},
                    ),
                    const SizedBox(height: 9),
                    _SettingsTile(
                      icon: Icons.dark_mode_outlined,
                      title: "Ilova ko'rinishi",
                      onTap: _showAppearanceSheet,
                    ),
                    const SizedBox(height: 9),
                    _SettingsTile(
                      icon: Icons.language,
                      title: 'Til',
                      onTap: _showLanguageSheet,
                    ),
                    const SizedBox(height: 9),
                    _SettingsTile(
                      icon: Icons.info_outline,
                      title: 'Ilova haqida',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 22),
                child: _OfferButton(onTap: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLanguageSheet() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.58),
      builder: (context) {
        return _LanguageSheet(selectedCode: selectedLanguageCode);
      },
    );

    if (selected == null || !mounted) return;
    setState(() => selectedLanguageCode = selected);
  }

  Future<void> _showAppearanceSheet() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.58),
      builder: (context) {
        return _AppearanceSheet(selectedCode: selectedAppearanceCode);
      },
    );

    if (selected == null || !mounted) return;
    setState(() => selectedAppearanceCode = selected);
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: onTap,
        child: const SizedBox(
          width: 34,
          height: 34,
          child: Icon(Icons.chevron_left, color: Color(0xFF8D9292), size: 29),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF0F2F0),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          height: 52,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF8B8F8F), size: 25),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF1F2428),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0,
                    ),
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

class _OfferButton extends StatelessWidget {
  const _OfferButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF0F2F0),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: const SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, color: Color(0xFF5FC66A), size: 24),
              SizedBox(width: 12),
              Text(
                'Ommaviy oferta',
                style: TextStyle(
                  color: Color(0xFF1F2428),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet({required this.selectedCode});

  final String selectedCode;

  static const _languages = [
    _LanguageOption(code: 'uz', title: "O'zbek", flag: '🇺🇿'),
    _LanguageOption(code: 'ru', title: 'Русский', flag: '🇷🇺'),
    _LanguageOption(code: 'en', title: 'English', flag: '🇬🇧'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 14, 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Til',
                      style: TextStyle(
                        color: Color(0xFF1F2428),
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Yopish',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    color: const Color(0xFF7C8181),
                    iconSize: 26,
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE9ECE9)),
            for (final language in _languages)
              _LanguageOptionTile(
                option: language,
                selected: language.code == selectedCode,
              ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({required this.option, required this.selected});

  final _LanguageOption option;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(option.code),
      child: SizedBox(
        height: 58,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(option.flag, style: const TextStyle(fontSize: 21)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  option.title,
                  style: const TextStyle(
                    color: Color(0xFF2A3033),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.circle_outlined,
                color: selected
                    ? const Color(0xFF009688)
                    : const Color(0xFF6D7373),
                size: 27,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageOption {
  const _LanguageOption({
    required this.code,
    required this.title,
    required this.flag,
  });

  final String code;
  final String title;
  final String flag;
}

class _AppearanceSheet extends StatelessWidget {
  const _AppearanceSheet({required this.selectedCode});

  final String selectedCode;

  static const _options = [
    _AppearanceOption(
      code: 'light',
      title: "Yorug'",
      icon: Icons.light_mode_outlined,
    ),
    _AppearanceOption(
      code: 'dark',
      title: "Qorong'u",
      icon: Icons.dark_mode_outlined,
    ),
    _AppearanceOption(
      code: 'system',
      title: 'Tizimli',
      icon: Icons.settings_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 14, 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Ilova ko'rinishi",
                      style: TextStyle(
                        color: Color(0xFF1F2428),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Yopish',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    color: const Color(0xFF7C8181),
                    iconSize: 26,
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE9ECE9)),
            for (final option in _options)
              _AppearanceOptionTile(
                option: option,
                selected: option.code == selectedCode,
              ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

class _AppearanceOptionTile extends StatelessWidget {
  const _AppearanceOptionTile({required this.option, required this.selected});

  final _AppearanceOption option;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(option.code),
      child: SizedBox(
        height: 58,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(option.icon, color: const Color(0xFF8B8F8F), size: 27),
              const SizedBox(width: 17),
              Expanded(
                child: Text(
                  option.title,
                  style: const TextStyle(
                    color: Color(0xFF2A3033),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.circle_outlined,
                color: selected
                    ? const Color(0xFF009688)
                    : const Color(0xFF6D7373),
                size: 27,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppearanceOption {
  const _AppearanceOption({
    required this.code,
    required this.title,
    required this.icon,
  });

  final String code;
  final String title;
  final IconData icon;
}
