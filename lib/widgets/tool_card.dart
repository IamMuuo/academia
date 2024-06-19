import 'package:academia/exports/barrel.dart';

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
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isLoading = true;
        });
        await widget.ontap.call();
        setState(() {
          _isLoading = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.shadow,
          ),
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(widget.heading),
              // subtitle: Text(subheading),
              // trailing: const Icon(Icons.favorite_outline),
            ),
            SizedBox(
              height: 200.0,
              child: _isLoading
                  ? const Text("Loading")
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
      ),
    );
  }
}
