import 'package:flutter/material.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
      margin: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      width: double.infinity,
      child: const Row(
        children: [
          Icon(Icons.search),
          SizedBox(width: 10),
          Text(
            "Enter a search term",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
