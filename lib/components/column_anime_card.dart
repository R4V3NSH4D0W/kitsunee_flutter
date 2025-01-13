import 'package:flutter/material.dart';

class ColumnAnimeCard extends StatelessWidget {
  final List<dynamic> results;
  final bool isFromSchedule;

  const ColumnAnimeCard({
    super.key,
    required this.results,
    this.isFromSchedule = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: results.map((result) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
            title: Column(
              children: [
                if (isFromSchedule)
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(result['airingTime']),
                    ],
                  ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: result['id'],
                        );
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              result['image'],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
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
                          const Positioned(
                            top: 50,
                            left: 50,
                            child: Icon(
                              Icons.play_circle,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            result['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                        Text(
                          result['duration'] != null &&
                                  result['duration'].isNotEmpty
                              ? result['duration']
                              : result["airingEpisode"] ?? '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.pink),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(Icons.add, color: Colors.pink),
                              Text(
                                'My List',
                                style: TextStyle(color: Colors.pink),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
