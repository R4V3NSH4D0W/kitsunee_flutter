import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  final List<dynamic> animeList;
  final String title;

  const AnimeCard({
    super.key,
    required this.animeList,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title),
        _buildAnimeList(),
      ],
    );
  }

  /// Function to build the title section
  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Function to build the horizontal anime list
  Widget _buildAnimeList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: animeList.length,
        itemBuilder: (context, index) {
          final anime = animeList[index];
          return _buildAnimeCard(anime);
        },
      ),
    );
  }

  /// Function to build each anime card
  Widget _buildAnimeCard(dynamic anime) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          anime['image'],
          fit: BoxFit.cover,
          width: 150,
          height: 200,
        ),
      ),
    );
  }
}
