import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  final List<dynamic> animeList;
  final String title;
  final bool seeAll;

  const AnimeCard({
    super.key,
    required this.animeList,
    required this.title,
    this.seeAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context, title),
        const SizedBox(height: 4),
        _buildAnimeList(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (seeAll)
            TextButton(
              onPressed: () {
                print('See All Tapped');
              },
              child: const Text(
                'See All',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimeList(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: animeList.length,
          itemBuilder: (context, index) {
            final anime = animeList[index];
            return _buildAnimeCard(context, anime);
          },
        ),
      ),
    );
  }

  Widget _buildAnimeCard(BuildContext context, dynamic anime) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: anime['id'],
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            anime['image'],
            fit: BoxFit.cover,
            width: 150,
            height: 200,
          ),
        ),
      ),
    );
  }
}
