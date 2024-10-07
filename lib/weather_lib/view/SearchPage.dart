import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/bottom_navigation_bar/bottom_navigator.dart';
import 'package:graduation_project/weather_lib/Serivces/WeatherServices.dart';
import 'package:graduation_project/weather_lib/models/WeatherModel.dart';
import 'package:graduation_project/weather_lib/view/searched_city.dart';
import '../widgets/city_card.dart';


class SearchPageweather extends StatefulWidget {
  const SearchPageweather({Key? key}) : super(key: key);
  @override
  _SearchPageweatherState createState() => _SearchPageweatherState();
}

class _SearchPageweatherState extends State<SearchPageweather> {
  late TextEditingController? _searchController;
  late WeatherModel weather;
  final List<String> cities = [
    'الفيوم',
    'القليوبية',
    'الإسكندرية',
    'القاهرة',
    'الزقازيق',
    'بني سويف',
    'الاقصر',
    'الغردقة',
    'الجيزة',
    'بور سعيد',
    'قنا',
    'كفر الشيخ',
    'سوهاج',
    'بنها',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  Future<void> fetchWeather(String city) async {
    try {
      WeatherModel fetchedWeather =
      await WeatherServices(Dio()).GetWeather(city: city);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchedCity(weather: fetchedWeather),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('خطأ'),
            content: Text('بيانات الطقس غير متوفرة. يرجى المحاولة مرة أخرى.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('موافق'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          iconSize: 22,
        ),
        backgroundColor: Color(0xFFD79977),
        title: Text(
          "الطقس ",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20,0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "ابحث عن مدينه لمعرفه الطقس ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                suffixIcon: IconButton(
                  onPressed: () async {
                    await fetchWeather(_searchController!.text);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      color:  Color(0xFFD79977),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return CityCard(
                    currentCity: cities[index],
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}