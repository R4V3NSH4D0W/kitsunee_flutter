import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/helper/api.helper.dart';
import 'package:provider/provider.dart';
import 'package:kitsunee_flutter/components/navbar.dart';
import 'package:kitsunee_flutter/providers/app_provider.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  Map<String, dynamic> animeDetails = {};
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();

    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.addListener(_onMyListChanged);

    fetchAllDetails(appProvider.myList);
  }

  @override
  void dispose() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.removeListener(_onMyListChanged);
    super.dispose();
  }

  void _onMyListChanged() {
    if (mounted) {
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      fetchAllDetails(appProvider.myList);
    }
  }

  Future<void> fetchAllDetails(List<String> ids) async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    Map<String, dynamic> details = {};

    try {
      for (String id in ids) {
        final detail = await fetchAnimeDetail(id: id);
        details[id] = detail;
      }

      if (mounted) {
        setState(() {
          animeDetails = details;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Navbar(),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<AppProvider>(
                  builder: (context, appProvider, child) {
                    final myList = appProvider.myList;
                    if (myList.isEmpty) {
                      return const Center(
                        child: Text(
                          'No items in your list.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    if (hasError) {
                      return const Center(
                        child: Text(
                          'Failed to load data. Please try again.',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      );
                    }

                    if (isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.pink),
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: myList.length,
                      itemBuilder: (context, index) {
                        final id = myList[index];
                        final detail = animeDetails[id];

                        if (detail == null) {
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text('No details available'),
                            ),
                          );
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: detail['id'],
                            );
                          },
                          child: Card(
                            elevation: 4,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              child: Image.network(
                                detail['image'] ??
                                    'https://via.placeholder.com/150',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
