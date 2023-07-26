import 'package:flutter/material.dart';
import 'package:internship_app/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:internship_app/push_notification/firebase_push_notification.dart';
import 'package:internship_app/search_list_screen.dart';
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

import 'package:internship_app/custom_widgets/image_card_widget.dart';
import 'package:internship_app/custom_widgets/search_box_widget.dart';

import 'package:flutter_carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Map<String, dynamic> jsonData = {};
List<dynamic> displayedListings = [];
List<dynamic> filteredList = [];
ScrollController _scrollController = ScrollController();
TextEditingController _searchTextController = TextEditingController();

class _HomePageState extends State<HomePage> {
  String img = "",
      price = "",
      model = "",
      condition = "",
      deviceStorage = "",
      listingLocation = "",
      listingDate = "";

  List filteredStorageList = [];
  List filteredMakersList = [];
  List filteredConditionList = [];

  String selectedFilteredStorage = "";
  String selectedFilteredMake = "";
  String selectedFilteredCondition = "";

  bool filterButton1Pressed = false;
  bool filterButton2Pressed = false;
  bool filterButton3Pressed = false;

  bool isFilterApplied = false;
  Future<Map<String, dynamic>> fetchData() async {
    final url = Uri.https(
      'dev2be.oruphones.com',
      '/api/v1/global/assignment/getListings',
      {
        'page': '1',
        'limit': '10',
      },
    );
    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // print('Failed to fetch listings');
      return {};
    }
  }

  Future<void> fetchFilteredData() async {
    final url = Uri.https(
      'dev2be.oruphones.com',
      '/api/v1/global/assignment/getFilters',
      {'isLimited': 'true'},
    );
    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      filteredMakersList = jsonData['filters']['make'];
      filteredConditionList = jsonData['filters']['condition'];
      filteredStorageList = jsonData['filters']['storage'];
      // print(filteredMakersList);
      // print(filteredConditionList);
      // print(filteredStorageList);
    } else {
      // print('Failed to fetch listings');
    }
  }

  void loadMoreData() async {
    if (jsonData['listings'] != null && jsonData['listings'].isNotEmpty) {
      final newJsonData = await fetchData();
      setState(() {
        jsonData['listings'].addAll(newJsonData['listings']);
        displayedListings = List.from(jsonData['listings']);
      });
    }
  }

  final _pushNotification = MessagingService();
  @override
  void initState() {
    super.initState();
    _pushNotification.init(context);
    fetchFilteredData();
    fetchData().then((data) {
      setState(() {
        jsonData = data;
        displayedListings = List.from(jsonData['listings']);
      });
    });
    _scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _searchTextController.dispose();
  }

  void onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      loadMoreData();
    }
  }

  void applyFilters() {
    setState(() {
      isFilterApplied = true;
      filteredList = displayedListings.where((element) {
        bool matchesStorage = selectedFilteredStorage.isNotEmpty
            ? element['deviceStorage']
                .toString()
                .contains(selectedFilteredStorage)
            : true;

        bool matchesMake = selectedFilteredMake.isNotEmpty
            ? element['model'].toString().contains(selectedFilteredMake)
            : true;

        bool matchesCondition = selectedFilteredCondition.isNotEmpty
            ? element['deviceCondition']
                .toString()
                .contains(selectedFilteredCondition)
            : true;

        // Combine the conditions using logical && (AND) operator
        return matchesStorage && matchesMake && matchesCondition;
      }).toList();

      // print(filteredList);
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          const Row(
            children: [
              Text(
                "Mumbai",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              FaIcon(FontAwesomeIcons.locationPin),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.bell),
          )
        ],
        title: Image.asset(
          "assets/images/logo.png",
          color: Colors.white,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchListScreen(),
                ),
              );
            },
            child: const SearchBoxWidget(),
          ),
        ),
      ),
      body: jsonData['listings'] == null
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: kPrimaryColor,
                size: 100,
              ),
            )
          : Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: CarouselSlider(
                      enableAutoSlider: true,
                      slideTransform: const DepthTransform(),
                      autoSliderTransitionTime: const Duration(seconds: 2),
                      autoSliderDelay: const Duration(seconds: 5),
                      unlimitedMode: true,
                      children: [
                        Image.asset('assets/images/banner1.png'),
                        Image.asset('assets/images/banner2.png'),
                        Image.asset('assets/images/banner3.png'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: isFilterApplied
                        ? filteredList.length
                        : displayedListings.length,
                    itemBuilder: (context, index) {
                      if (isFilterApplied) {
                        img = filteredList[index]['images'][0]["fullImage"];
                        price =
                            filteredList[index]['listingNumPrice'].toString();
                        model = filteredList[index]['model'];
                        condition = filteredList[index]['deviceCondition'];
                        deviceStorage = filteredList[index]['deviceStorage'];
                        listingLocation =
                            filteredList[index]['listingLocation'];
                        listingDate = filteredList[index]['listingDate'];
                      } else {
                        img =
                            displayedListings[index]['images'][0]["fullImage"];
                        price = displayedListings[index]['listingNumPrice']
                            .toString();
                        model = displayedListings[index]['model'];
                        condition = displayedListings[index]['deviceCondition'];
                        deviceStorage =
                            displayedListings[index]['deviceStorage'];
                        listingLocation =
                            displayedListings[index]['listingLocation'];
                        listingDate = displayedListings[index]['listingDate'];
                      }

                      return Card(
                        elevation: 0,
                        child: ImageCardWidget(
                          img: img,
                          price: price,
                          model: model,
                          deviceStorage: deviceStorage,
                          condition: condition,
                          listingLocation: listingLocation,
                          listingDate: listingDate,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home,
          Icons.filter_alt,
          Icons.file_copy,
          Icons.person,
        ],
        backgroundColor: kPrimaryColor,
        activeIndex: 0,
        iconSize: 30,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.sharpEdge,
        activeColor: Colors.white,
        inactiveColor: Colors.white30,
        onTap: (index) {
          if (index == 1) {
            showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Storage",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            direction: Axis.horizontal,
                            children: filteredStorageList.map((item) {
                              return ElevatedButton(
                                onPressed: () {
                                  selectedFilteredStorage = item;
                                  applyFilters();
                                },
                                style: kFilterButtonStyle,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Brands",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            direction: Axis.horizontal,
                            children: filteredMakersList.map((item) {
                              return ElevatedButton(
                                onPressed: () {
                                  selectedFilteredMake = item;
                                  applyFilters();
                                },
                                style: kFilterButtonStyle,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Condition",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            direction: Axis.horizontal,
                            children: filteredConditionList.map((item) {
                              return ElevatedButton(
                                onPressed: () {
                                  selectedFilteredCondition = item;
                                  applyFilters();
                                },
                                style: kFilterButtonStyle,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: kFilterActionButtonStyle,
                        onPressed: () {
                          setState(() {
                            isFilterApplied = false;
                            selectedFilteredCondition = "";
                            selectedFilteredMake = "";
                            selectedFilteredStorage = "";
                            filteredList = [];
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Clear Filters"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
        notchMargin: 0,
      ),
    );
  }
}
