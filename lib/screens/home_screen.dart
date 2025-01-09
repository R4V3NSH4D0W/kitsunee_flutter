import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/components/anime_card.dart';
import 'package:kitsunee_flutter/helper/api.helper.dart';
import 'package:kitsunee_flutter/wrappers/layout_wrapper.dart';

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

  @override
  void initState() {
    super.initState();
    populatAnime = fetchPopularAnime();
    mostFavoriteAnime = fetchMostFavorite();
    topAiringAnime = fetchTopAiring();
    movieAnime = fetchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutWrapper(
      child: Scaffold(
        body: FutureBuilder<List<dynamic>>(
          future: Future.wait(
              [populatAnime, mostFavoriteAnime, topAiringAnime, movieAnime]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final List<dynamic> animeData = snapshot.data![0];
              final List<dynamic> favoriteAnimeData = snapshot.data![1];
              final List<dynamic> topAiringAnimeData = snapshot.data![2];
              final List<dynamic> movieAnime = snapshot.data![3];

              return ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  AnimeCard(
                    title: "Popular",
                    animeList: animeData,
                  ),
                  AnimeCard(
                    title: "Most Favorite",
                    animeList: favoriteAnimeData,
                  ),
                  AnimeCard(title: "Top Airing", animeList: topAiringAnimeData),
                  AnimeCard(animeList: movieAnime, title: "Movie"),
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
