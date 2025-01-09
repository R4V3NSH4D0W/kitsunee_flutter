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
                    //  show details
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      result['image'],
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    Text(
                      result['duration'],
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
