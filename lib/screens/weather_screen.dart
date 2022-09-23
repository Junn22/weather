import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:weather_jun_app/model/model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key, this.parseWeatherData, this.parseAirPollution}) : super(key: key);

  final dynamic parseWeatherData;
  final dynamic parseAirPollution;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName;
  int? temp;
  Model model = Model();

  Widget? icon;
  Widget? airIcon;
  Widget? airState;
  String? des;
  double? dust1;
  int? dust2;

  var date = DateTime.now();

  @override
  void initState() {
    super.initState();

    print(widget.parseWeatherData);
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData) {

    int condition = weatherData['weather'][0]['id'];
    int index = airData['list'][0]['main']['aqi'];
    double temp2 = weatherData['main']['temp'];
    temp = temp2.toInt(); // 정수
    //temp = temp2.round(); // 반올림
    cityName = weatherData['name'];
    icon = model.getWeatherIcon(condition);
    des = weatherData['weather'][0]['description'];
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];
    icon = model.getAirIcon(index);
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);

    print(temp);
    print(cityName);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat('h:mm a').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(''),
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.near_me)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.location_searching)),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Image.asset('image/background.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 150),
                              Text('$cityName',
                                  style: GoogleFonts.lato(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
                              Row(
                                children: [
                                  TimerBuilder.periodic(Duration(minutes: 1), builder: (context) {
                                    print('${getSystemTime()}');
                                    return Text('${getSystemTime()}',
                                        style: GoogleFonts.lato(fontSize: 16.0, color: Colors.white));
                                  }),
                                  Text(
                                    DateFormat(' - EEEE').format(date),
                                    style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                                  ),
                                  Text(DateFormat(' d MMM, yyy').format(date),
                                      style: GoogleFonts.lato(fontSize: 16, color: Colors.white))
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$temp\u2103',
                                  style: GoogleFonts.lato(fontSize: 85.0, fontWeight: FontWeight.w300, color: Colors.white)),
                              Row(
                                children: [
                                  //Icon, //위젯 null을 어떻게 처리하나?
                                  Icon(Icons.wallet),
                                  SizedBox(width: 10),
                                  Text('$des', style: GoogleFonts.lato(
                                    fontSize: 16, color: Colors.white
                                  ))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          height: 15,
                          thickness: 2,
                          color: Colors.white30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('AQI(대기질지수)', style: GoogleFonts.lato(
                                    fontSize: 14, color: Colors.white
                                ),),
                                SizedBox(height: 10),
                                //airIcon, //위젯 null을 어떻게 처리하나?
                                Image.asset('image/bad.png', width: 37, height: 35),
                                SizedBox(height: 10),
                                Text('매우나쁨', style: GoogleFonts.lato(
                                  fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold,
                                ),)
                              ],
                            ),
                            Column(
                              children: [
                                Text('미세먼지', style: GoogleFonts.lato(
                                    fontSize: 14, color: Colors.white
                                ),),
                                SizedBox(height: 10),
                                Text('$dust1', style: GoogleFonts.lato(
                                    fontSize: 24, color: Colors.white
                                ),),
                                SizedBox(height: 10),
                                Text('㎍/㎥', style: GoogleFonts.lato(
                                  fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold,
                                ),)
                              ],
                            ),
                            Column(
                              children: [
                                Text('초미세먼지', style: GoogleFonts.lato(
                                    fontSize: 14, color: Colors.white
                                ),),
                                SizedBox(height: 10),
                                Text('$dust2', style: GoogleFonts.lato(
                                    fontSize: 24, color: Colors.white
                                ),),
                                SizedBox(height: 10),
                                Text('㎍/㎥', style: GoogleFonts.lato(
                                  fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold,
                                ))
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
