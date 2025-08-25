import 'package:flutter/foundation.dart';
import '../../../domain/models/mute_suggestion.dart';

class MuteController extends ChangeNotifier {
  final List<MuteSuggestion> _items;
  final Set<String> _selected = {};

  MuteController(List<MuteSuggestion> initial)
      : _items = List.unmodifiable(initial);

  List<MuteSuggestion> get items => _items;
  Set<String> get selectedIds => _selected;

  bool isSelected(String id) => _selected.contains(id);

  void toggle(String id) {
    if (_selected.contains(id)) {
      _selected.remove(id);
    } else {
      _selected.add(id);
    }
    notifyListeners();
  }

  void clear() {
    _selected.clear();
    notifyListeners();
  }

  void selectAll() {
    _selected
      ..clear()
      ..addAll(_items.map((e) => e.id));
    notifyListeners();
  }

  int get selectedCount => _selected.length;

  // Stubs for future integration:
  Future<void> muteSelected() async {
    // TODO: Implement OS-specific muting/links. For now, just clear selection.
    _selected.clear();
    notifyListeners();
  }

  Future<void> applySmartMuting() async {
    // TODO: Use heuristics to decide which to mute or soften.
    _selected
      ..clear()
      ..addAll(_items.take(3).map((e) => e.id)); // example: pick top-3
    notifyListeners();
  }
}
