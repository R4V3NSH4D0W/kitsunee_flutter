import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/components/anime_card.dart';
import 'package:kitsunee_flutter/helper/api.helper.dart';
import 'package:kitsunee_flutter/components/slider_widget.dart';

class AnimeDataCache {
  List<dynamic>? popularAnime;
  List<dynamic>? mostFavoriteAnime;
  List<dynamic>? topAiringAnime;
  List<dynamic>? movieAnime;
  List<dynamic>? spotLight;

  bool isCacheValid() {
    return popularAnime != null &&
        mostFavoriteAnime != null &&
        topAiringAnime != null &&
        movieAnime != null &&
        spotLight != null;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  static final AnimeDataCache _cache = AnimeDataCache();

  late Future<List<dynamic>> populatAnime;
  late Future<List<dynamic>> mostFavoriteAnime;
  late Future<List<dynamic>> topAiringAnime;
  late Future<List<dynamic>> movieAnime;
  late Future<List<dynamic>> spotLight;

  @override
  void initState() {
    super.initState();
    if (!_cache.isCacheValid()) {
      _fetchDataAndPopulateCache();
    }
  }

  void _fetchDataAndPopulateCache() {
    spotLight = fetchSpotLight().then((data) {
      _cache.spotLight = data;
      return data;
    });
    populatAnime = fetchPopularAnime().then((data) {
      _cache.popularAnime = data;
      return data;
    });
    mostFavoriteAnime = fetchMostFavorite().then((data) {
      _cache.mostFavoriteAnime = data;
      return data;
    });
    topAiringAnime = fetchTopAiring().then((data) {
      _cache.topAiringAnime = data;
      return data;
    });
    movieAnime = fetchMovie().then((data) {
      _cache.movieAnime = data;
      return data;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          _cache.spotLight != null ? Future.value(_cache.spotLight) : spotLight,
          _cache.popularAnime != null
              ? Future.value(_cache.popularAnime)
              : populatAnime,
          _cache.mostFavoriteAnime != null
              ? Future.value(_cache.mostFavoriteAnime)
              : mostFavoriteAnime,
          _cache.topAiringAnime != null
              ? Future.value(_cache.topAiringAnime)
              : topAiringAnime,
          _cache.movieAnime != null
              ? Future.value(_cache.movieAnime)
              : movieAnime
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<dynamic> spotLightData = snapshot.data![0];
            final List<dynamic> animeData = snapshot.data![1];
            final List<dynamic> favoriteAnimeData = snapshot.data![2];
            final List<dynamic> topAiringAnimeData = snapshot.data![3];
            final List<dynamic> movieAnimeData = snapshot.data![4];

            return ListView(
              children: [
                SliderWidget(spotLight: spotLightData),
                AnimeCard(
                  title: "Popular",
                  animeList: animeData,
                ),
                AnimeCard(
                  title: "Most Favorite",
                  animeList: favoriteAnimeData,
                ),
                AnimeCard(
                  title: "Top Airing",
                  animeList: topAiringAnimeData,
                ),
                AnimeCard(
                  title: "Movie",
                  animeList: movieAnimeData,
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
