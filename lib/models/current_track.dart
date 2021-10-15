class CurrentTrack {
  final int id;
  final String artist;
  final String title;
  final String album;
  final String nextTrack;
  final String cover;

  CurrentTrack({
    required this.id,
    required this.artist,
    required this.title,
    required this.nextTrack,
    required this.cover,
    required this.album,
  });

  factory CurrentTrack.fromJson(Map<String, dynamic> json) {
    return CurrentTrack(
      id: json['id'],
      artist: json['artist'] ?? '',
      title: json['title'] ?? '',
      nextTrack: json['next_track'] ?? '',
      cover: json['cover'] ?? '',
      album: json['album'] ?? '',
    );
  }
}
