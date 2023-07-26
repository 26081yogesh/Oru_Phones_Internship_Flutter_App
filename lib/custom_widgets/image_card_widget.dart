import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:internship_app/constants/constants.dart';

class ImageCardWidget extends StatefulWidget {
  const ImageCardWidget({
    super.key,
    required this.img,
    required this.price,
    required this.model,
    required this.deviceStorage,
    required this.condition,
    required this.listingLocation,
    required this.listingDate,
  });

  final String img;
  final String price;
  final String model;
  final String deviceStorage;
  final String condition;
  final String listingLocation;
  final String listingDate;

  @override
  State<ImageCardWidget> createState() => _ImageCardWidgetState();
}

class _ImageCardWidgetState extends State<ImageCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: widget.img,
              width: 100,
              fit: BoxFit.fill,
              height: 100,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Text(
            "Rs ${widget.price}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            textAlign: TextAlign.left,
          ),
          Text(
            widget.model,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.deviceStorage, style: klistItemsTextStyle),
                Text("Condition: ${widget.condition}",
                    style: klistItemsTextStyle),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.listingLocation, style: klistItemsTextStyle),
              Text(widget.listingDate, style: klistItemsTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
