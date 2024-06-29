import 'package:flutter/material.dart';

class EditTextBox extends StatelessWidget {

  final String text;
  final String sectionName;
  final void Function()? onPressed;

  const EditTextBox({super.key, required this.sectionName, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8)
      ),
      padding: const EdgeInsets.only(
          left: 15.0,
          bottom: 15.0
      ),
      margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700
                ),),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.settings,
                    color: Colors.grey[500],))
            ],
          ),
          Text(text,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.w700
            ),)
        ],
      ),
    );
  }
}
