#EnergyOS — Youth Lifestyle Copilot
Privacy‑first energy management and digital wellness app built with Flutter. Users log quick daily check‑ins, get personalized energy metrics, outcomes, and smart rebalancing suggestions, plus a Digital Clutter Detox with mute recommendations. All core analysis runs on‑device.

##Screens
Dashboard: Energy level, Sleep quality, Social battery, Mood, Burnout risk, Recovery time, Today’s Energy Budget, embedded Quick Check‑in, and Smart Rebalance CTA.

Check‑in: 30‑second sliders for Sleep, Mood, and Social Battery with a single “Update Energy Ledger” action.

###Outcomes: Weekly Burnout Risk (before/after), Recovery Time Gained, Digital Clutter Impact, and Privacy Score.

###Detox: KPIs (screenshots organized, notifications bundled, clutter reduced, time reclaimed), OCR Smart Actions list, and interactive Mute Suggestions with batch actions.

###Settings: Demo Mode toggle (persisted), privacy info, crash reporting stub, reset demo data, version, and licenses.

##Tech stack
Flutter (Material 3, Dark theme)

Riverpod for state management and dependency injection

GoRouter for navigation

SharedPreferences for persisted settings (Demo Mode)

Planned: Android UsageStats, Health Connect (Android) / HealthKit (iOS), optional charts/animations

Project structure
lib/

app/ … application shell (MaterialApp.router), theme, and router provider

core/di/ … provider wiring (repositories, services, demo mode, prefs)

domain/ … models (CheckIn, DailyMetrics, EnergyBudget, Usage), pure services (ScoringService, EnergyBudgetService)

data/ … repositories (MetricsRepository, UsageRepository demo)

features/

dashboard/ … presentation

checkin/ … presentation

outcomes/ … presentation

detox/ … presentation + mute selection controller

settings/ … presentation

platform/ … native channel scaffolds (usage, health) to be implemented

ui/ … reusable UI kit (cards, chips, progress, tiles, banner)

##Key concepts
Demo Mode: Renders polished, permission‑free data across screens and is persisted locally. Useful for demos/hackathons and as a fallback when permissions are denied or features aren’t available on device.

Pure domain services: ScoringService and EnergyBudgetService are deterministic (no I/O), making them simple to test and reuse.

Provider hygiene: Screens watch only what they need (e.g., select) to minimize rebuilds and keep performance snappy.

Getting started
Prerequisites:

Flutter SDK (stable channel)

Dart 3.x

Android Studio or Xcode (for platform builds)

Install:

Clone the repo

flutter pub get

Run on a simulator or device:

Android: flutter run -d android

iOS: flutter run -d ios

Configuration
Demo Mode is on by default and persisted via SharedPreferences.

Toggle it in Settings. When off, the app will prompt for platform permissions (once the usage/health integrations are enabled).

No secrets or API keys required for the current demo flow.

Navigation
GoRouter with named routes:

dashboard: /

checkin: /checkin

rebalance: /rebalance

outcomes: /outcomes

detox: /detox

settings: /settings

Current features (implemented)
Domain

CheckIn and DailyMetrics models

ScoringService: energy, burnout risk, recovery hours from check‑ins

EnergyBudgetService: simple allocator for Today’s Energy Budget

Data + DI

MetricsRepository (ChangeNotifier) exposing latest metrics

Demo UsageRepository scaffold

Riverpod providers for repositories, services, and demo mode

UI

UI Kit: AppCard, SectionHeader, AppChip, ProgressStat, StatCard, InfoTile, SuggestionRow, DemoBanner

Dashboard, Check‑in, Outcomes, Detox (with interactive Mute Suggestions), Rebalance placeholder

Settings with persisted Demo Mode toggle, reset demo data, privacy copy, licenses

Roadmap (next)
Android usage integration

Implement native bridge for UsageStats: availability, permission, weekly app usage

Wire Detox KPIs and Mute Suggestions to live data when Demo Mode is off

Sleep via Health Connect / HealthKit

Read daily sleep sessions and provide averages to ScoringService

Update Outcomes “Recovery Time Gained” using real data where available

Smart Rebalance engine

Generate 3–5 targeted suggestions from DailyMetrics (+ optional usage/sleep signals)

Accept/Undo with in‑memory history

Editable Energy Budget

Replace static items with a small tasks repo and edit bottom sheet (add/remove/edit)

Recompute remaining% in real time

Polish

Subtle entrance animations (fade/slide) for sections

Haptics on primary actions

Accessibility labels, contrast checks, consistent iconography

Testing

Unit tests for ScoringService, EnergyBudgetService, DemoModeNotifier

Widget tests for Check‑in flow and Detox mute selection

Golden tests for UI kit components

Contributing
Branch from main

Use conventional commits when possible

Include tests for logic changes

Open a PR with a clear description, screenshots for UI changes, and steps to verify

License
Add your license of choice (e.g., MIT, Apache 2.0) in LICENSE at the repo root.

Credits
RaoSam-Code and Team
