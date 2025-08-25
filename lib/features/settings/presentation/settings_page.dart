import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// DI: exposes demoModeProvider and any future settings repos/providers.
import '../../../core/di/providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // GENERAL
          const _SectionTitle('General'),
          const SizedBox(height: 8),
          const _DemoModeSwitch(),
          const SizedBox(height: 8),
          _SettingTile(
            title: 'Theme',
            subtitle: 'Dark',
            leading: const Icon(Icons.dark_mode_outlined),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: push theme selection page or show a bottom sheet
            },
          ),

          const SizedBox(height: 24),

          // PRIVACY
          const _SectionTitle('Privacy'),
          const SizedBox(height: 8),
          _SettingTile(
            title: 'Privacy',
            subtitle: 'All data processed on-device',
            leading: const Icon(Icons.verified_user_outlined),
            onTap: () {
              // Optional: open a page w/ privacy copy
            },
          ),
          _SettingTile(
            title: 'Crash reporting',
            subtitle: 'Share anonymous diagnostics',
            leading: const Icon(Icons.privacy_tip_outlined),
            trailing: _SwitchInline(
              initial: false,
              onChanged: (v) {
                // TODO: wire to analytics/crash toggle
              },
            ),
          ),

          const SizedBox(height: 24),

          // DATA
          const _SectionTitle('Data'),
          const SizedBox(height: 8),
          _SettingTile(
            title: 'Reset demo data',
            subtitle: 'Restore sample metrics and suggestions',
            leading: const Icon(Icons.replay_outlined),
            onTap: () {
              // TODO: clear any persisted demo flags/data and repopulate
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Demo data reset')),
              );
            },
          ),

          const SizedBox(height: 24),

          // ABOUT
          const _SectionTitle('About'),
          const SizedBox(height: 8),
          _SettingTile(
            title: 'Version',
            subtitle: '1.0.0',
            leading: const Icon(Icons.info_outline),
            onTap: () {
              // Optional: pull from package_info_plus
            },
          ),
          _SettingTile(
            title: 'Licenses',
            leading: const Icon(Icons.article_outlined),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showLicensePage(context: context),
          ),

          const SizedBox(height: 24),

          // FOOTER
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF13171C),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.lock_outline, color: color.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'EnergyOS is privacy‑first. No cloud sync required.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class _SettingTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;

  const _SettingTile({
    required this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF13171C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: leading,
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}

/// Demo Mode toggle backed by Riverpod state.
/// When ON, Detox/Outcomes render polished data without prompting for permissions.
class _DemoModeSwitch extends ConsumerWidget {
  const _DemoModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demo = ref.watch(demoModeProvider);
    return _SettingTile(
      title: 'Demo mode',
      subtitle: 'Populate the app with sample data',
      leading: const Icon(Icons.rocket_launch_outlined),
      trailing: _SwitchInline(
        initial: demo,
        onChanged: (v) => ref.read(demoModeProvider.notifier).state = v,
      ),
      onTap: () => ref.read(demoModeProvider.notifier).state = !demo,
    );
  }
}

/// Small inline switch used inside list tiles.
class _SwitchInline extends StatefulWidget {
  final bool initial;
  final ValueChanged<bool>? onChanged;
  const _SwitchInline({required this.initial, this.onChanged, super.key});

  @override
  State<_SwitchInline> createState() => _SwitchInlineState();
}

class _SwitchInlineState extends State<_SwitchInline> {
  late bool value = widget.initial;

  @override
  void didUpdateWidget(covariant _SwitchInline oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initial != widget.initial) {
      value = widget.initial;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (v) {
        setState(() => value = v);
        widget.onChanged?.call(v);
      },
    );
  }
}
