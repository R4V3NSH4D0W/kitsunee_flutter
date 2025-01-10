import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    if (widget.animeId != null) {
      _combinedAnimeDetail = _fetchCombinedDetails(widget.animeId!);
    }
  }

  Future<Map<String, dynamic>> _fetchCombinedDetails(String id) async {
    try {
      final animeDetail = await fetchAnimeDetail(id: id);
      if (animeDetail['malID'] != null) {
        final jikanAnimeDetail =
            await fetchJikanAnime(malId: animeDetail['malID']);

        return {...animeDetail, ...jikanAnimeDetail};
      } else {
        return animeDetail;
      }
    } catch (e) {
      throw Exception('Failed to fetch combined anime details: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _combinedAnimeDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final anime = snapshot.data!;
              String description = anime['description'] ?? '';
              String shortDescription = description.length > 300
                  ? '${description.substring(0, 300)}...'
                  : description;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 300,
                            child: Image.network(
                              anime['image'],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              color: const Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Title and action buttons
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            anime['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
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
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.pink),
                              const SizedBox(width: 5),
                              Text(
                                anime['score'].toString(),
                                style: const TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.pink,
                              ),
                              const SizedBox(width: 5),
                              Text(anime['year'].toString()),
                              const SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Colors.pink,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    trimRating(anime['rating']),
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.46,
                                child: AAElevatedButton(
                                  label: 'Play',
                                  icon: Icons.play_arrow,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.46,
                                child: AAOutlinedButton(
                                  label: 'Download',
                                  icon: Icons.download,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => _showDescriptionBottomSheet(
                              context,
                              description,
                            ),
                            child: Text(
                              shortDescription,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
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
}
