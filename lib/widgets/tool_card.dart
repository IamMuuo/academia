import 'package:flutter/material.dart';

class ToolCard extends StatefulWidget {
  const ToolCard({
    super.key,
    required this.heading,
    required this.image,
    required this.description,
    required this.ontap,
    required this.action,
  });
  final String heading;
  final String image;
  final String description;
  final Function ontap;
  final String action;

  @override
  State<ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<ToolCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.heading),
            // subtitle: Text(subheading),
            trailing: const Icon(Icons.favorite_outline),
          ),
          SizedBox(
            height: 200.0,
            child: Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(widget.description),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: Text(widget.action),
                onPressed: () {
                  widget.ontap.call();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
