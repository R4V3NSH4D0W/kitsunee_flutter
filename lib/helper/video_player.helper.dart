import 'package:kitsunee_flutter/helper/api.helper.dart';

class Source {
  final bool isM3U8;
  final String url;

  Source({required this.isM3U8, required this.url});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      isM3U8: json['isM3U8'],
      url: json['url'],
    );
  }
}

class EpisodeSources {
  final List<Source> sources;

  EpisodeSources({required this.sources});

  factory EpisodeSources.fromJson(Map<String, dynamic> json) {
    return EpisodeSources(
      sources: (json['sources'] as List)
          .map((source) => Source.fromJson(source))
          .toList(),
    );
  }
}

String? getHlsSource(EpisodeSources? episodeSources) {
  if (episodeSources == null || episodeSources.sources.isEmpty) {
    return null;
  }
  return episodeSources.sources
      .firstWhere((source) => source.isM3U8,
          orElse: () => Source(isM3U8: false, url: ''))
      .url;
}

Future<Map<String, dynamic>> fetchAnimeAndEpisodeData(
    String animeID, String episodeID) async {
  try {
    final episodeSources = await fetchEpisodeSource(id: episodeID);
    final animeInfo = await fetchAnimeDetail(id: animeID);
    return {'episodeSources': episodeSources, 'animeInfo': animeInfo};
  } catch (error) {
    rethrow;
  }
}

Map<String, dynamic>? findEnglishSubtitle(List<dynamic> subtitles) {
  return subtitles.firstWhere((subtitle) => subtitle['lang'] == 'English',
      orElse: () => null);
}
