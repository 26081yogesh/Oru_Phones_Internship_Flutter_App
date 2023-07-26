import 'package:flutter/material.dart';
import 'package:internship_app/constants/constants.dart';

class SearchScreenWidget extends StatelessWidget {
  const SearchScreenWidget({
    super.key,
    required this.makers,
    required this.models,
  });

  final List makers;
  final List models;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Brands", style: kSearchCardsTitle),
        ),
        Expanded(
          flex: 1,
          child: Card(
            elevation: 3,
            child: ListView.builder(
              itemCount: makers.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(makers[index]),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Mobile Models", style: kSearchCardsTitle),
        ),
        Expanded(
          flex: 2,
          child: Card(
            elevation: 3,
            child: ListView.builder(
              itemCount: models.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(models[index]),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
