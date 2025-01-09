class AnimeResult {
  final String id;
  final String title;
  final String image;
  final String url;
  final List<String>? genres;
  final String episodeId;
  final int episodeNumber;
  final String? duration;
  final String? japaneseTitle;
  final String? type;
  final int? sub;
  final int? dub;
  final int? episodes;

  AnimeResult({
    required this.id,
    required this.title,
    required this.image,
    required this.url,
    this.genres,
    required this.episodeId,
    required this.episodeNumber,
    this.duration,
    this.japaneseTitle,
    this.type,
    this.sub,
    this.dub,
    this.episodes,
  });
  factory AnimeResult.fromJson(Map<String, dynamic> json) {
    return AnimeResult(
      id: json['id'],
      title: json['title'],
      image: json['image'] ?? '',
      url: json['url'],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : null,
      episodeId: json['episodeId'],
      episodeNumber: json['episodeNumber'],
      duration: json['duration'],
      japaneseTitle: json['japaneseTitle'],
      type: json['type'],
      sub: json['sub'],
      dub: json['dub'],
      episodes: json['episodes'],
    );
  }
}

class AnimeResponse {
  final int currentPage;
  final bool hasNextPage;
  final List<AnimeResult> results;

  AnimeResponse({
    required this.currentPage,
    required this.hasNextPage,
    required this.results,
  });

  // Define fromJson method to deserialize API response
  factory AnimeResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<AnimeResult> animeList =
        list.map((i) => AnimeResult.fromJson(i)).toList();

    return AnimeResponse(
      currentPage: json['currentPage'],
      hasNextPage: json['hasNextPage'],
      results: animeList,
    );
  }
}

// Episode model
class Episode {
  final String id;
  final int number;
  final String url;

  Episode({
    required this.id,
    required this.number,
    required this.url,
  });
}

// Anime model
class Anime {
  final String id;
  final String title;
  final String url;
  final List<String> genres;
  final int totalEpisodes;
  final String image;
  final String releaseDate;
  final String description;
  final String subOrDub;
  final String type;
  final String status;
  final String otherName;
  final List<Episode> episodes;
  final int altID;
  final int malID;
  final JikanAnimeResponse? jikan;
  final List<AnimeResult>? recommendations;

  Anime({
    required this.id,
    required this.title,
    required this.url,
    required this.genres,
    required this.totalEpisodes,
    required this.image,
    required this.releaseDate,
    required this.description,
    required this.subOrDub,
    required this.type,
    required this.status,
    required this.otherName,
    required this.episodes,
    required this.altID,
    required this.malID,
    this.jikan,
    this.recommendations,
  });
}

// IEpisodeSource model
class IEpisodeSource {
  final String name;
  final String url;

  IEpisodeSource({
    required this.name,
    required this.url,
  });
}

// ISpotLightResult model
class ISpotLightResult {
  final String id;
  final String title;
  final String japaneseTitle;
  final String banner;
  final int rank;
  final String url;
  final String type;
  final String duration;
  final String releaseDate;
  final String quality;
  final int sub;
  final int dub;
  final int episodes;
  final String description;

  ISpotLightResult({
    required this.id,
    required this.title,
    required this.japaneseTitle,
    required this.banner,
    required this.rank,
    required this.url,
    required this.type,
    required this.duration,
    required this.releaseDate,
    required this.quality,
    required this.sub,
    required this.dub,
    required this.episodes,
    required this.description,
  });
}

// ISpotLight model
class ISpotLight {
  final List<ISpotLightResult> results;

  ISpotLight({
    required this.results,
  });
}

// RootStackParamList type
class RootStackParamList {
  static const String tabs = 'Tabs';
  static const String detail = 'Detail';
  static const String videoScreen = 'VideoScreen';
  static const String search = 'Search';
  static const String sortAndFilter = 'SortAndFilter';
  static const String seeAll = 'SeeAll';
  static const String updateScreen = 'UpdateScreen';
}

// DateItem model
class DateItem {
  final String id;
  final int day;
  final String weekday;

  DateItem({
    required this.id,
    required this.day,
    required this.weekday,
  });
}

// JikanAnimeResponse model
class JikanAnimeResponse {
  final Data data;

  JikanAnimeResponse({required this.data});
}

class Data {
  final int malId;
  final String url;
  final bool approved;
  final String title;
  final String? titleEnglish;
  final String titleJapanese;
  final List<String> titleSynonyms;
  final String type;
  final String source;
  final int? episodes;
  final String status;
  final String duration;
  final String rating;
  final double? score;
  final int? scoredBy;
  final int? rank;
  final int popularity;
  final int members;
  final int favorites;
  final String? synopsis;
  final String? background;
  final String? season;
  final int? year;

  Data({
    required this.malId,
    required this.url,
    required this.approved,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.titleSynonyms,
    required this.type,
    required this.source,
    required this.episodes,
    required this.status,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.background,
    required this.season,
    required this.year,
  });
}

// Define other nested models (Images, Trailer, Titles, Airing, etc.) as required.
