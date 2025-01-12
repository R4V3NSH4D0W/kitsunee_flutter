import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitsunee_flutter/components/column_anime_card.dart';
import 'package:kitsunee_flutter/components/navbar.dart';
import 'package:kitsunee_flutter/helper/api.helper.dart';
import 'package:kitsunee_flutter/helper/utils.helper.dart';

class ScheduleDataCache {
  List<dynamic>? scheduleData;
  DateTime? lastFetchedTime;
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<dynamic> _scheduleData = [];
  dynamic _selectedSchedule;
  bool loading = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (_scheduleData.isEmpty) {
      _fetchScheduleData();
    }
  }

  Future<void> _fetchScheduleData({String? date}) async {
    setState(() {
      loading = true;
    });

    String dateToFetch =
        date ?? DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      var data = await fetchReleaseSchedule(date: dateToFetch);
      final enrichedSchedule = await Future.wait(
        data.map((item) async {
          try {
            final animeInfo = await fetchAnimeDetail(id: item['id']);
            return {
              ...item,
              'image': animeInfo['image'] ?? 'https://via.placeholder.com/150',
            };
          } catch (error) {
            return {
              ...item,
              'image': 'https://via.placeholder.com/150',
            };
          }
        }),
      );

      if (!mounted) return;

      setState(() {
        loading = false;
        if (enrichedSchedule.isNotEmpty) {
          _scheduleData = enrichedSchedule;
          _selectedSchedule = _scheduleData[0];
          final initialDate = DateTime.parse(enrichedSchedule[0]['date']);
          _selectedDate = initialDate;
        } else {
          _scheduleData = [];
          _selectedSchedule = null;
          _selectedDate = null;
        }
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Navbar(),
              const SizedBox(height: 20),
              _calendarList(),
              const SizedBox(height: 20),
              if (loading)
                Expanded(
                  child: Center(
                    child: const CircularProgressIndicator(),
                  ),
                ),
              if (!loading && _selectedSchedule != null)
                Expanded(child: ColumnAnimeCard(results: _scheduleData)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calendarList() {
    final List<Map<String, DateTime>> dates = generateDates();

    if (_selectedDate == null && dates.isNotEmpty) {
      _selectedDate = dates[0]['date'];
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: dates.map((date) {
          final isSelected = _isSameDate(_selectedDate, date['date']);

          return GestureDetector(
            onTap: () async {
              final formattedDate =
                  DateFormat('yyyy-MM-dd').format(date['date']!);

              setState(() {
                _selectedDate = date['date'];
              });

              await _fetchScheduleData(date: formattedDate);
            },
            child: Container(
              height: 80,
              width: 50,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.pink : Colors.transparent,
                border: Border.all(
                    color: isSelected ? Colors.pink : Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('d').format(date['date']!),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('EEE').format(date['date']!),
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  bool _isSameDate(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return DateFormat('yyyy-MM-dd').format(date1) ==
        DateFormat('yyyy-MM-dd').format(date2);
  }
}
