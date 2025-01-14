import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/components/column_anime_card.dart';
import 'package:kitsunee_flutter/helper/api.helper.dart';

class SeeAllScreen extends StatefulWidget {
  final String? type;
  const SeeAllScreen({super.key, required this.type});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<dynamic> _items = [];
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchItems(widget.type, _currentPage);
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchItems(String? type, int page) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<dynamic> newItems;
      switch (type) {
        case 'Popular':
          newItems = await fetchPopularAnime(number: page);
          break;
        case 'Most Favorite':
          newItems = await fetchMostFavorite(number: page);
          break;
        case 'Top Airing':
          newItems = await fetchTopAiring(number: page);
          break;
        case 'Movie':
          newItems = await fetchMovie(number: page);
          break;
        default:
          newItems = [];
      }

      if (!mounted) return;

      setState(() {
        _items.addAll(newItems);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.5 &&
        !_isLoading) {
      _currentPage++;
      _fetchItems(widget.type, _currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _buildNavbar(widget.type ?? 'All'),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _items.length + 1,
                      itemBuilder: (context, index) {
                        if (index < _items.length) {
                          return ColumnAnimeCard(results: [_items[index]]);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading && _items.isEmpty)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavbar(String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Text(
              type,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(
              Icons.search,
              size: 28,
            )),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
