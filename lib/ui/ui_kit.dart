import 'package:flutter/material.dart';

// Typography helpers
TextStyle _titleLg(BuildContext c) =>
    Theme.of(c).textTheme.titleLarge ??
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
TextStyle _titleMd(BuildContext c) =>
    Theme.of(c).textTheme.titleMedium ??
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
TextStyle _bodySm(BuildContext c) =>
    Theme.of(c).textTheme.bodySmall ?? const TextStyle(fontSize: 12);

// Common card surface
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bg = color ?? const Color(0xFF13171C);
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

// Section header with optional chip on the right
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? margin;
  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(title, style: _titleMd(context)),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

// Small pill chip
class AppChip extends StatelessWidget {
  final String label;
  final Color? color;
  final IconData? icon;
  const AppChip({super.key, required this.label, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = (color ?? scheme.primary).withOpacity(0.15);
    final fg = color ?? scheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 6),
          ],
          Text(label,
              style: _bodySm(context)
                  .copyWith(color: fg, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// Metric with label + right-aligned value and a progress bar
class ProgressStat extends StatelessWidget {
  final String title;
  final String valueText;
  final double progress01; // 0..1
  final IconData? icon;
  final Color? color;
  const ProgressStat({
    super.key,
    required this.title,
    required this.valueText,
    required this.progress01,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = color ?? scheme.primary;
    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null)
                Icon(icon, size: 18, color: scheme.onSurface.withOpacity(0.8)),
              if (icon != null) const SizedBox(width: 8),
              Expanded(child: Text(title, style: _titleMd(context))),
              Text(valueText, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress01.clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: scheme.onSurface.withOpacity(0.1),
              color: accent,
            ),
          ),
        ],
      ),
    );
  }
}

// Simple stat tile: number + caption
class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String caption;
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: scheme.primary),
          const SizedBox(height: 8),
          Text(value, style: _titleLg(context)),
          const SizedBox(height: 4),
          Text(caption,
              style: _bodySm(context).copyWith(color: scheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

// Info tile with title, value, and small caption
class InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final String caption;
  final Color? color;
  const InfoTile({
    super.key,
    required this.title,
    required this.value,
    required this.caption,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _titleMd(context)),
          const SizedBox(height: 8),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(caption,
              style: _bodySm(context).copyWith(color: scheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

// Row item for suggestions lists (Detox/Outcomes)
class SuggestionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  const SuggestionRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: scheme.primary),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}

// Bottom demo banner
class DemoBanner extends StatelessWidget {
  final String textLeft;
  final String ctaLabel;
  final VoidCallback? onTap;
  const DemoBanner({
    super.key,
    required this.textLeft,
    required this.ctaLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.secondary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              textLeft,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black.withOpacity(0.85),
              foregroundColor: Colors.white,
            ),
            onPressed: onTap,
            child: Text(ctaLabel),
          ),
        ],
      ),
    );
  }
}
