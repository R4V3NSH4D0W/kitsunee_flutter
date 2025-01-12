import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/components/anime_card.dart';
import 'package:kitsunee_flutter/helper/api.helper.dart';
import 'package:kitsunee_flutter/helper/utils.helper.dart';

import 'package:kitsunee_flutter/ui/buttons.dart';

class DetailScreen extends StatefulWidget {
  final String? animeId;

  const DetailScreen({super.key, required this.animeId});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Map<String, dynamic>> _combinedAnimeDetail;
  final TextEditingController _searchController = TextEditingController();
  List filteredEpisodes = [];

  @override
  void initState() {
    super.initState();
    if (widget.animeId != null) {
      _combinedAnimeDetail = _fetchCombinedDetails(widget.animeId!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> _fetchCombinedDetails(String id) async {
    try {
      final animeDetail = await fetchAnimeDetail(id: id);

      if (animeDetail['malID'] != null) {
        final jikanAnimeDetail =
            await fetchJikanAnime(malId: animeDetail['malID']);
        return {
          'AnimeDetail': animeDetail,
          'JikenData': jikanAnimeDetail,
        };
      } else {
        return {
          'AnimeDetail': animeDetail,
          'JikenData': {},
        };
      }
    } catch (e) {
      throw Exception('Failed to fetch combined anime details: $e');
    }
  }

  void _filterEpisodes(String query, List episodes) {
    setState(() {
      filteredEpisodes = query.isEmpty
          ? episodes
          : episodes
              .where((episode) => episode['number'].toString().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _combinedAnimeDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final anime = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(anime),
                    _buildTitleAndActions(anime),
                    _buildRatingAndInfo(anime),
                    _buildPlayAndDownloadButtons(),
                    _buildDescription(anime),
                    _buildEpisodes(anime['AnimeDetail']['episodes'],
                        anime['AnimeDetail']['image']),
                    AnimeCard(
                      animeList: anime["AnimeDetail"]["recommendations"],
                      title: 'More Like This',
                      seeAll: false,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No data'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildEpisodes(List episodes, String image) {
    if (filteredEpisodes.isEmpty) {
      filteredEpisodes = episodes;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Episodes",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _filterEpisodes(value, episodes),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  hintText: 'Search Episode',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredEpisodes.length,
                itemBuilder: (context, index) {
                  final episode = filteredEpisodes[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                                width: 180,
                                height: 150,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                  "Episode ${episode['number'].toString()}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Positioned(
                                top: 50,
                                left: 70,
                                child: Icon(
                                  Icons.play_circle,
                                  color: Colors.white,
                                  size: 40,
                                ))
                          ],
                        )),
                  );
                },
              ),
            ))
      ]),
    );
  }

  Widget _buildHeader(Map<String, dynamic> anime) {
    return Stack(
      children: [
        Image.network(
          anime['AnimeDetail']['image'],
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.3),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndActions(Map<String, dynamic> anime) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              anime['AnimeDetail']['title'],
              softWrap: true,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          Row(
            children: const [
              Icon(Icons.bookmarks_outlined),
              SizedBox(width: 10),
              Icon(Icons.share_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingAndInfo(Map<String, dynamic> anime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.pink),
          const SizedBox(width: 5),
          Text(
            anime['JikenData']['score'].toString(),
            style: const TextStyle(
                color: Colors.pink, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.pink),
          const SizedBox(width: 5),
          Text(anime['JikenData']['year'].toString()),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.pink, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                trimRating(anime['JikenData']['rating']),
                style: const TextStyle(color: Colors.pink),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayAndDownloadButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.46,
            child: AAElevatedButton(
              label: 'Play',
              icon: Icons.play_arrow,
              onPressed: () {
                // Play button action
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.46,
            child: AAOutlinedButton(
              label: 'Download',
              icon: Icons.download,
              onPressed: () {
                // Download button action
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(Map<String, dynamic> anime) {
    String description = anime['AnimeDetail']['description'] ?? '';
    String shortDescription = description.length > 300
        ? '${description.substring(0, 300)}...'
        : description;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: () => _showDescriptionBottomSheet(context, description),
        child: Text(shortDescription, style: const TextStyle(fontSize: 12)),
      ),
    );
  }

  void _showDescriptionBottomSheet(BuildContext context, String description) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(description, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
