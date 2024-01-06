import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  bool _isLoading = false;
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
          _isLoading
              ? LoadingAnimationWidget.beat(
                  color: Theme.of(context).primaryColor, size: 80)
              : SizedBox(
                  height: 200.0,
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.fitWidth,
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
                  _isLoading = true;
                  widget.ontap.call();
                  _isLoading = false;
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
