import 'package:flutter/material.dart';

class ColumnAnimeCard extends StatelessWidget {
  final List<dynamic> results;

  const ColumnAnimeCard({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: results.map((result) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            title: Row(
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
                        Positioned(
                            top: 50,
                            left: 50,
                            child: Icon(
                              Icons.play_circle,
                              color: Colors.white,
                              size: 40,
                            ))
                      ],
                    )),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        result['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    Text(
                      result['duration'] != null &&
                              result['duration'].isNotEmpty
                          ? result['duration']
                          : result["airingEpisode"] ?? '',
                      style: TextStyle(color: Colors.grey),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.pink),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.pink),
                          Text(
                            'My List',
                            style: TextStyle(color: Colors.pink),
                          ),
                        ],
                      ),
                    )
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
