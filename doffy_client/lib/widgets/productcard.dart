import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String imageurl;
  final String offerTag;
  final Function onTap;
  const ProductCard(
      {super.key,
      required this.name,
      required this.imageurl,
      required this.offerTag,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageurl,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 142,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 29, 162, 219),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  offerTag,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
