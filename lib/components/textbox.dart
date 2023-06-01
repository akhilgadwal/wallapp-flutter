import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;
  final String sectioname;
  const TextBox({super.key, required this.text, required this.sectioname});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15.0,
        bottom: 15.0,
      ),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectioname,
                style: TextStyle(color: Colors.grey.shade500),
              ),
              const Icon(
                Icons.settings,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(text),
        ],
      ),
    );
  }
}
