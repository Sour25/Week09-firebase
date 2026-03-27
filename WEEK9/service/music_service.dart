
import '../model/songs/song.dart';
import '../model/songs/songs_detail.dart';
import '../data/repositories/artists/artist_repository.dart';
import '../data/repositories/songs/song_repository.dart';
import '../model/artists/artist.dart';


class MusicService {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;

  MusicService({required this.songRepository, required this.artistRepository});

  Future<List<SongDetails>> fetchSongDetails() async {
    List<Song> songs = await songRepository.fetchSongs();

    List<Artist> artists = await artistRepository.fetchArtists();

    Map<String, Artist> mapArtist = {};
    for (Artist artist in artists) {
      mapArtist[artist.id] = artist;
    }

    return songs
        .map(
          (song) => SongDetails(song: song, artist: mapArtist[song.artistId]!),
        )
        .toList();
  }
}
