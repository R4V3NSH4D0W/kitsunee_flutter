import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/components/anime_card.dart';
import 'package:kitsunee_flutter/helper/api.helper.dart';
import 'package:kitsunee_flutter/wrappers/layout_wrapper.dart';
import 'package:kitsunee_flutter/components/slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> populatAnime;
  late Future<List<dynamic>> mostFavoriteAnime;
  late Future<List<dynamic>> topAiringAnime;
  late Future<List<dynamic>> movieAnime;
  late Future<List<dynamic>> spotLight;

  @override
  void initState() {
    super.initState();
    populatAnime = fetchPopularAnime();
    mostFavoriteAnime = fetchMostFavorite();
    topAiringAnime = fetchTopAiring();
    movieAnime = fetchMovie();
    spotLight = fetchSpotLight(); // Fetch spotlight data
  }

  @override
  Widget build(BuildContext context) {
    return LayoutWrapper(
      child: Scaffold(
        body: FutureBuilder<List<dynamic>>(
          future: Future.wait([
            spotLight,
            populatAnime,
            mostFavoriteAnime,
            topAiringAnime,
            movieAnime
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
      ),
    );
  }
}
