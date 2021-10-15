abstract class PlaylistRepository {
  Future<List<Map<String, String>>> fetchInitialPlaylist();
  Future<Map<String, String>> fetchAnotherSong();
}

class DemoPlaylist extends PlaylistRepository {
  @override
  Future<List<Map<String, String>>> fetchInitialPlaylist(
      {int length = 2}) async {
    return List.generate(length, (index) => _nextSong());
  }

  @override
  Future<Map<String, String>> fetchAnotherSong() async {
    return _nextSong();
  }

  var _songIndex = 0;
  static const _maxSongNumber = 2;

  Map<String, String> _nextSong() {
    _songIndex = (_songIndex % _maxSongNumber) + 1;
    return {
      'id': _songIndex == 1 ? 'island-pulse' : 'laid-back-island-pulse',
      'title': _songIndex == 1 ? 'Main Stream' : 'Laid Back',
      'album': 'Online',
      'channel_name': _songIndex == 1 ? 'Main Stream' : 'Laid Back',
      'url':
      _songIndex == 1
          ? 'https://www.radioking.com/play/island-pulse'
          : 'https://www.radioking.com/play/laid-back-island-pulse',
      'data':
      _songIndex == 1
          ? 'https://api.radioking.io/widget/radio/island-pulse/track/current'
          : 'https://api.radioking.io/widget/radio/laid-back-island-pulse/track/current',
    };
  }
}
