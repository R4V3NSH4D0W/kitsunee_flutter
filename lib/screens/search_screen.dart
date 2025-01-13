import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/components/column_anime_card.dart';
import 'package:kitsunee_flutter/helper/api.helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  List<dynamic> _results = [];
  List<dynamic> _popularAnime = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPopularAnime();
  }

  Future<void> _fetchPopularAnime() async {
    setState(() {
      _isLoading = true;
    });
    List<dynamic> popularAnime = await fetchPopularAnime();
    setState(() {
      _popularAnime = popularAnime;
      _isLoading = false;
    });
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1, milliseconds: 500), () async {
      if (query.isNotEmpty) {
        setState(() {
          _isLoading = true;
        });
        List<dynamic> results = await fetchSearchResult(query: query);
        setState(() {
          _results = results;
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            hintText: 'Search...',
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
                      SizedBox(width: 10),
                      ButtonTheme(
                        child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide.none,
                              backgroundColor: Colors.pink[200],
                              minimumSize: Size(40, 50),
                            ),
                            child: const Icon(
                              Icons.tune,
                              size: 26,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (!_isLoading)
                    Expanded(
                      child: ColumnAnimeCard(
                        results:
                            _controller.text.isEmpty ? _popularAnime : _results,
                      ),
                    ),
                ],
              ),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
