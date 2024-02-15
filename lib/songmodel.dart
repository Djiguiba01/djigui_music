class SongModel {
  final String id;
  final String title;
  final String artist;
  final String albumArtAssetPath;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumArtAssetPath,
  });
}

SongModel song = SongModel(
  id: '1',
  title: 'Song Title',
  artist: 'Artist Name',
  albumArtAssetPath:
      'assets/images/album1.jpg', // Chemin de l'image de l'album dans les ressources
);
