import 'package:flutter/material.dart';
import 'package:graduation_project/weather_lib/view/SearchPage.dart';
import '../widgets/more_details_card.dart';

class DetailsPage extends StatefulWidget {
  final String city;
  final double Temperature;
  final String condition;
  final double wind;
  final int clouds;
  final num uv;
  final num humidity;
  final double visibility;
  final double pressure;
  final String sunrise;
  final String sunset;

  DetailsPage({
    Key? key,
    required this.city,
    required this.condition,
    required this.wind,
    required this.clouds,
    required this.uv,
    required this.humidity,
    required this.visibility,
    required this.pressure,
    required this.Temperature,
    required this.sunrise,
    required this.sunset,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPageweather(),
              ),
            );
          },
        ),
        title: Text(
          'تفاصيل الطقس',
          style: TextStyle(color: Colors.white), // Text color
        ),
        centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: Container(
                width: 250,
                height: 45,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 241, 241),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 125,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xFFD79977),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "طقس اليوم",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 125,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "${widget.city}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MoreDetailsCard(
                  imagePath: "assets/weather/im8.png",
                  text1: "فوق البنفسجية",
                  text2: "${widget.uv} Low",
                  imageWidth: 50,
                  imageHeight: 60,
                ),
                MoreDetailsCard(
                  imagePath: "assets/weather/im4.png",
                  text1: "درجة الحرارة ",
                  text2: "${widget.Temperature}",
                  imageWidth: 70,
                  imageHeight: 60,
                ),
                MoreDetailsCard(
                  imagePath: "assets/weather/im5.png",
                  text1: "الرياح",
                  text2: "${widget.wind} Km",
                  imageWidth: 70,
                  imageHeight: 60,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MoreDetailsCard(
                  imagePath: "assets/weather/im9.png",
                  text1: "الرطوبة",
                  text2: "${widget.humidity}%",
                  imageWidth: 120,
                  imageHeight: 60,
                ),
                MoreDetailsCard(
                  imagePath: "assets/weather/im10.png",
                  text1: "ضغط الهواء",
                  text2: "${widget.pressure}",
                  imageWidth: 50,
                  imageHeight: 60,
                ),
                MoreDetailsCard(
                  imagePath: "assets/weather/im11.png",
                  text1: "الرؤية",
                  text2: "${widget.visibility} Km",
                  imageWidth: 50,
                  imageHeight: 60,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: 380,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/weather/im12.png",
                          width: 50,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          "الشروق",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.sunrise}",
                        style: TextStyle(
                          color:Color(0xFFD79977),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${widget.sunset}",
                        style: TextStyle(
                          color: Color(0xFFD79977),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    children: [
                      Image.asset(
                        "assets/weather/im13.png",
                        width: 110,
                        height: 70,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        "الغروب",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
