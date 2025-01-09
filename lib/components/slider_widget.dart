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
                      Positioned(
                          bottom: 20,
                          left: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                            ],
                          )),
                    ],
                  );
                },
              );
            },
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Text(
            "Kitsunee",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
