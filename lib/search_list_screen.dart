import 'package:flutter/material.dart';
import 'package:internship_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:internship_app/custom_widgets/search_screen_widget.dart';

class SearchListScreen extends StatefulWidget {
  const SearchListScreen({super.key});

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  List models = [];
  List makers = [];
  Future<void> searchFunctionality(String query) async {
    final url = Uri.https(
      "dev2be.oruphones.com",
      "/api/v1/global/assignment/searchModel",
    );

    final Map<String, dynamic> requestBody = {
      'searchModel': query,
    };

    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(url,
          headers: headers, body: json.encode(requestBody));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        List modelsList = List.from(responseData['models']);
        List makersList = List.from(responseData['makes']);
        // print(modelsList);
        // print(makersList);

        setState(() {
          models = modelsList.map((items) => items).toList();
          makers = makersList.map((items) => items).toList();
        });
      } else {
        // print(
        //     'Failed to fetch data. Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      // print('Error occurred: $e');
    }
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: ((value) {
                setState(() {
                  searchFunctionality(value);
                });
              }),
              decoration: kSearchBarDecoration,
            ),
          ),
        ),
      ),
      body: SearchScreenWidget(makers: makers, models: models),
    );
  }
}
