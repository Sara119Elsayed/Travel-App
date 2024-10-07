import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Search/screens/landmark_search.dart';
import 'package:graduation_project/bottom_navigation_bar/bottom_navigator.dart';
import 'package:graduation_project/configrution/places.dart';
import 'package:graduation_project/configrution/places_list.dart';
import 'package:graduation_project/src/drawer/maindrawer.dart';
import 'package:graduation_project/src/icon%20pages/ChatScreen.dart';
import 'package:graduation_project/src/icon%20pages/FavoritesPage.dart';
import 'package:graduation_project/src/map/file1.dart';
import 'package:graduation_project/ui/tripplanner.dart';
import 'package:graduation_project/weather_lib/view/SearchPage.dart';
import '../icon pages/ActivitiesPage.dart';
import '../icon pages/HeritageSite.dart';
import '../icon pages/HotelsPage.dart';
import '../icon pages/NearbyPlacesPage.dart';
import '../icon pages/RestaurantsPage.dart';
import '../icon pages/SearchPage.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> imageList = [
    "assets/images/places/img2.jpg",
    "assets/images/places/img1.jpg",
    "assets/images/places/img3.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5), // مسافة بين الشريط والحواف العلوية
              Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  },
                  child: SizedBox(
                    height: 50,
                    width: double.infinity, // Make button full width
                    child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // تعيين لون الزر
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)), // تعيين شكل الحواف
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LandmarkSearchPage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'ابحث عن معالم, ووجهات سياحية,انشطه....',
                                style: TextStyle( color:Colors.black54),
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: Color(0xFFD79977),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),    /// 20.0 - 10.0
                  child: FutureBuilder<List<Places>>(
                    future: bringThePlaces(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return SizedBox(
                          height:200,               /// 200.0
                          width: SizeConfig.screenWidth,                        /// 411.0
                          child: CarouselSlider(
                            options: CarouselOptions(
                              enableInfiniteScroll: true,
                              enlargeCenterPage: true,
                              autoPlay: false,
                            ),
                            items: imageList.map((e) => ClipRRect(
                              borderRadius : BorderRadius.circular(20),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(e, fit: BoxFit.cover,)
                                ],
                              ),
                            )).toList(),
                          ),
                        );
                      }
                      else{
                        return Center();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height:10),
              // القائمة القابلة للتمرير لعرض الأيقونات والعبارات
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildIconCard(Icons.camera_alt, 'تعرف على الأثر', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HeritageSitePage()),
                        );
                      }),
                      _buildIconCard(Icons.card_travel, 'اقتراح رحله', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TripPlanner()),
                        );
                      }),
                      _buildIconCard(Icons.place_outlined, 'معالم محيطة', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>MapScreen ()),
                        );
                      }),
                      _buildIconCard(Icons.chat_outlined, 'محادثة جماعية', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ChatScreen()),
                        );
                      }),
                      _buildIconCard(Icons.wb_sunny, 'الطقس', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPageweather()),
                        );
                      }),


                      // _buildIconCard(Icons.restaurant, 'المطاعم', () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => RestaurantsPage()),
                      //   );
                      // }),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      'اماكن قد تعجبك',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width:170),

                    Icon(Icons.keyboard_arrow_left, color: Colors.black45, size: 32)   ,/// 32.0

                    SizedBox(height: 10),
                  ],
                ),
              ), // مسافة بين القائمة الأماكن والعناصر السابقة

              FutureBuilder<List<Places>>(
                future: bringThePlaces(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    var placeList = snapshot.data;
                    return SingleChildScrollView(
                      child: SizedBox(
                        height: 265,               /// 265.0
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: placeList!.length,
                          itemBuilder: (context, index){
                            var place = placeList[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: (){},
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                      12,             /// 12.0
                                      4,           /// 4.0
                                      10,              /// 10.0
                                      4,           /// 4.0
                                    ),
                                    height: 250,             /// 250.0
                                    width: 200,              /// 200.0
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(4, 6),
                                            blurRadius: 4,
                                            color: Colors.black.withOpacity(0.3),
                                          )
                                        ]
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage("${place.PlaceImageName}"),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.4),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        Positioned(
                                            right:40,            /// 12.0
                                            bottom: 15,         /// 15.0
                                            child: Column(

                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("${place.PlaceName}", style: TextStyle(fontSize: 20, color: Colors.white)),       /// 20
                                                Text("${place.PlaceCategory}", style: TextStyle(fontSize: 14, color: Colors.white)),   /// 14
                                                Text("${place.PlacePrice} ج.م", style: TextStyle(fontSize: 18, color: Colors.white))     /// 18
                                              ],
                                            )
                                        ),
                                        Positioned(
                                            top: 10,              /// 10.0
                                            left: 10,             /// 10.0
                                            child: Icon(Icons.favorite, color: Colors.white))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }
                  else{
                    return Center();
                  }
                },
              ),
              SizedBox(height: 40),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'انشطة',
              //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(width:180),
              //
              //       Icon(Icons.keyboard_arrow_left, color: Colors.black45, size: 32)   ,/// 32.0
              //
              //       SizedBox(height: 10),
              //     ],
              //   ),
              // ),
              // مسافة بين العنوان والعناصر
              // القائمة الأماكن
            ],

          ),
        ),

      ),
      drawer: Maindrawer(),// bottomNavigationBar: CurvedNavigationBar(),
    );
  }

  Widget _buildIconCard(IconData icon, String text, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 85,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 30,
                color: Color(0xFFD79977),
              ),
              SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(
                  color: Color(0xFFD79977),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

// عنصر لعرض الأيقونة والعبارة
class IconCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const IconCard({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // عند النقر على العنصر
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10), // المسافة بين العناصر
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // حدود العنصر
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: Color(0xFFD79977),
            ),
            SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
