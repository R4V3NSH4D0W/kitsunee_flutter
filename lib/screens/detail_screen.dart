import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/helper/api.helper.dart';

class DetailScreen extends StatefulWidget {
  final String? animeId;

  const DetailScreen({super.key, required this.animeId});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Map<String, dynamic>> _animeDetail;

  @override
  void initState() {
    super.initState();
    if (widget.animeId != null) {
      _animeDetail = fetchAnimeDetail(id: widget.animeId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _animeDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final anime = snapshot.data!;
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
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                          children: [
                            const Icon(Icons.bookmarks_outlined),
                            SizedBox(width: 10),
                            const Icon(Icons.share_outlined)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ));
            } else {
              return const Center(child: Text('No data'));
            }
          },
        ),
      ),
    );
  }
}
