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
          SizedBox(
            height: 200.0,
            child: _isLoading
                ? LoadingAnimationWidget.flickr(
                    leftDotColor: Theme.of(context).primaryColor,
                    rightDotColor: Theme.of(context).primaryColorDark,
                    size: 80,
                  )
                : Image.asset(
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
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await widget.ontap.call();
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
