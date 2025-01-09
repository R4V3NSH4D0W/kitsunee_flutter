import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final List<dynamic> spotLight;
  const SliderWidget({super.key, required this.spotLight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: spotLight.length,
            itemBuilder: (context, index) {
              final item = spotLight[index];
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Image.network(
                        item['banner'],
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                              child: Icon(Icons.error, color: Colors.white));
                        },
                      ),
                      Positioned.fill(
                        child: Container(
                          color: const Color.fromRGBO(0, 0, 0, 0.3),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(250, 250, 250, 1.1),
                                Colors.transparent,
                              ],
                              stops: [
                                0.0,
                                1.0,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rank ${item['rank']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              item['title'] ?? 'No Title',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Play",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink[600],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    "My List",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        Positioned(
          top: 10,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kitsunee",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  iconSize: 32,
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
