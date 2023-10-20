import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/pages/login_signup/login.controller.dart';
import 'package:doctor_pro/pages/screens.dart';
import 'package:doctor_pro/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  String city = 'Wallington';

  final doctorTypeList = [
    {'type': 'Cough & Fever', 'image': 'assets/icons/patient.png'},
    {'type': 'Homoeopath', 'image': 'assets/icons/stethoscope.png'},
    {'type': 'Gynecologist', 'image': 'assets/icons/woman.png'},
    {'type': 'Pediatrician', 'image': 'assets/icons/pediatrician.png'},
    {'type': 'Physiotherapist', 'image': 'assets/icons/physiotherapist.png'},
    {'type': 'Nutritionist', 'image': 'assets/icons/nutritionist.png'},
    {'type': 'Spine and Pain Specialist', 'image': 'assets/icons/pain.png'},
    {'type': 'Dentist', 'image': 'assets/icons/dentist.png'}
  ];

  final labList = [
    {
      'name': 'New York City DOHMH Public Health Laboratory',
      'image': 'assets/lab/lab_1.jpg',
      'address': '455 1st Avenue, New York, NY 10016, United States',
      'lat': 40.7392475,
      'lang': -73.9795667
    },
    {
      'name': 'Enzo Clinical Labs -Upper East Side (STAT Lab)',
      'image': 'assets/lab/lab_2.jpg',
      'address': '44 E 67th St, New York, NY 10022, United States',
      'lat': 40.7760308,
      'lang': -73.978491
    },
    {
      'name': 'New York Startup Lab LLC',
      'image': 'assets/lab/lab_3.jpg',
      'address': '244 5th Ave #2575, New York, NY 10001, United States',
      'lat': 40.7446378,
      'lang': -73.989919
    },
    {
      'name': 'MEDTRICS LAB LLC',
      'image': 'assets/lab/lab_4.jpg',
      'address': '138 W 25th St 10th floor, New York, NY 10001, United States',
      'lat': 40.7446713,
      'lang': -73.9957658
    },
    {
      'name': 'Enzo Clinical Labs',
      'image': 'assets/lab/lab_5.jpg',
      'address': '15005 21st Ave, Flushing, NY 11357, United States',
      'lat': 40.717053,
      'lang': -74.0011905
    },
    {
      'name': 'Shiel Medical Laboratory',
      'image': 'assets/lab/lab_6.jpg',
      'address': '128 Mott St, New York, NY 10013, United States',
      'lat': 40.7184989,
      'lang': -73.9986809
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: InkWell(
          onTap: () => _selectCityBottomSheet(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: blackColor,
                size: 18.0,
              ),
              SizedBox(width: 5.0),
              Text(
                city,
                style: appBarLocationTextStyle,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                      child: Notifications()));
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Search Start
          search(),
          // Search End

          // Banner Start
          banner(),
          // Banner End
          heightSpace,
          heightSpace,
          // Find doctor by speciality Start
          doctorBySpeciality(),
          // Find doctor by speciality End
          heightSpace,
          heightSpace,
          // Lab tests & health checkup start
          healthCheckup(),
          // Lab tests & health checkup end
        ],
      ),
    );
  }

  search() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: Search()));
      },
      child: Container(
        margin: EdgeInsets.all(fixPadding * 2.0),
        padding: EdgeInsets.all(fixPadding * 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 0.5, color: greyColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search, color: greyColor, size: 23.0),
            SizedBox(width: 5.0),
            Text('What type of appointment?', style: greySearchTextStyle),
          ],
        ),
      ),
    );
  }

  banner() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: width,
      height: height / 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage('assets/banner.jpg'),
          fit: BoxFit.fill,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 1.0,
            spreadRadius: 1.0,
            color: Colors.grey[400]!,
          ),
        ],
      ),
    );
  }

  doctorBySpeciality() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            'Find your doctor by speciality',
            style: blackHeadingTextStyle,
          ),
        ),
        Container(
          height: 190.0,
          child: ListView.builder(
            itemCount: doctorTypeList.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = doctorTypeList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 800),
                      type: PageTransitionType.fade,
                      child: DoctorList(
                        doctorType: item['type'],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 180.0,
                  padding: EdgeInsets.all(fixPadding),
                  alignment: Alignment.center,
                  margin: (index == doctorTypeList.length - 1)
                      ? EdgeInsets.all(fixPadding * 2.0)
                      : EdgeInsets.only(
                          left: fixPadding * 2.0,
                          top: fixPadding * 2.0,
                          bottom: fixPadding * 2.0),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(width: 0.3, color: lightPrimaryColor),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.grey[300]!,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        item['image']!,
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.cover,
                      ),
                      heightSpace,
                      Text(
                        item['type']!,
                        style: blackNormalBoldTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.fade,
                      child: Speciality()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'View All',
                  style: primaryColorNormalBoldTextStyle,
                ),
                SizedBox(width: 5.0),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: blackColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  healthCheckup() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      color: scaffoldBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lab tests & health checkup',
            style: blackHeadingTextStyle,
          ),
          ColumnBuilder(
            itemCount: labList.length,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            itemBuilder: (context, index) {
              final item = labList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(milliseconds: 600),
                          type: PageTransitionType.rightToLeft,
                          child: Lab(
                            name: item['name'] as String?,
                            address: item['address'] as String?,
                            image: item['image'] as String?,
                            lat: item['lat'],
                            lang: item['lang'],
                          )));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: fixPadding * 2.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: whiteColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.grey[300]!,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 180.0,
                        width: width / 3.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10.0)),
                          image: DecorationImage(
                            image: AssetImage(item['image'] as String),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(fixPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] as String,
                                style: blackNormalBoldTextStyle,
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                item['address'] as String,
                                style: greySmallBoldTextStyle,
                              ),
                              heightSpace,
                              Container(
                                padding: EdgeInsets.all(fixPadding),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      width: 0.7, color: primaryColor),
                                ),
                                child: Text(
                                  'Call now',
                                  style: primaryColorsmallBoldTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 165.0,
                        width: 30.0,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 18.0,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          heightSpace,
          heightSpace,
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 600),
                      type: PageTransitionType.rightToLeft,
                      child: LabList()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'View All',
                  style: primaryColorNormalBoldTextStyle,
                ),
                SizedBox(width: 5.0),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: blackColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet for Select City Start Here
  void _selectCityBottomSheet() {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: whiteColor,
            child: new Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Choose City',
                            textAlign: TextAlign.center,
                            style: blackHeadingTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              city = 'Wallington';
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Text('Wallington'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              city = 'Central Park';
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Text('Central Park'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              city = 'Nerobi';
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Text('Nerobi'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
  // Bottom Sheet for Select City Ends Here
}
