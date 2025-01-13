import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  List<String> _myList = [];
  List<String> _watchedEpisodes = [];
  Map<String, dynamic>? _continueWatching;

  List<String> get myList => _myList;
  List<String> get watchedEpisodes => _watchedEpisodes;
  Map<String, dynamic>? get continueWatching => _continueWatching;

  AppProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _myList = prefs.getStringList('myList') ?? [];
    _watchedEpisodes = prefs.getStringList('watchedEpisodes') ?? [];

    final continueWatchingString = prefs.getString('continueWatching');
    if (continueWatchingString != null) {
      _continueWatching =
          jsonDecode(continueWatchingString) as Map<String, dynamic>;
    }
    notifyListeners();
  }

  Future<void> addToList(String id) async {
    _myList.add(id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('myList', _myList);
    notifyListeners();
  }

  Future<void> removeFromList(String id) async {
    _myList.remove(id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('myList', _myList);
    notifyListeners();
  }

  bool isInList(String id) => _myList.contains(id);

  Future<void> markAsWatched(String id, double watchedPercentage) async {
    if (watchedPercentage >= 30 && !_watchedEpisodes.contains(id)) {
      _watchedEpisodes.add(id);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('watchedEpisodes', _watchedEpisodes);
      notifyListeners();
    }
  }

  bool isWatched(String id) => _watchedEpisodes.contains(id);

  Future<void> setContinueWatching(
      String id, String image, String name, int episodeNumber) async {
    _continueWatching = {
      'id': id,
      'image': image,
      'name': name,
      'episodeNumber': episodeNumber,
    };

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('continueWatching', jsonEncode(_continueWatching));
    notifyListeners();
  }

  Future<void> removeContinueWatching() async {
    _continueWatching = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('continueWatching');
    notifyListeners();
  }
}
