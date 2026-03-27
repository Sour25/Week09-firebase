import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
    'week9-practice-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  @override
  Future<List<Song>> fetchSongs() async {
    final response = await http.get(songsUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? bodyJson = jsonDecode(response.body);

     
      if (bodyJson == null) return [];

      List<Song> songs = [];

      bodyJson.forEach((id, data) {
        songs.add(SongDto.fromJson(id, data));
      });

      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    final Uri songUri = Uri.https(
      'week9-practice-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/songs/$id.json',
    );

    final response = await http.get(songUri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data == null) return null;

      return SongDto.fromJson(id, data);
    } else {
      throw Exception('Failed to load song');
    }
  }
}
