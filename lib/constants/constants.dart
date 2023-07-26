import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xff2C2E43);

const kSearchBarDecoration = InputDecoration(
  border: OutlineInputBorder(),
  hintText: 'Enter a search term',
  hintStyle: TextStyle(color: Colors.black, fontSize: 16),
  filled: true,
  contentPadding: EdgeInsets.all(0),
  fillColor: Color(0xffffffff),
  prefixIcon: Icon(Icons.search, color: Colors.black),
);

const klistItemsTextStyle = TextStyle(fontSize: 8);

const kSearchCardsTitle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

var kFilterButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  padding: const EdgeInsets.all(20),
);

var kFilterActionButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  padding: const EdgeInsets.all(20),
);
