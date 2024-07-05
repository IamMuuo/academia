import 'package:academia/exports/barrel.dart';

class FeesCard extends StatelessWidget {
  const FeesCard({
    super.key,
    required this.data,
    this.index = 0,
  });
  final Map<String, dynamic> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(data["ref"].toString().title()),
        leading: CircleAvatar(
          child: Text("${index + 1}"),
        ),
        contentPadding: EdgeInsets.zero,
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data["description"].toString().trim(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Row(
              children: [
                Text(
                  "Posting Date: ",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                Text(
                  data["posting_date"].toString().trim(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),

            // Currencies
            Row(
              children: [
                Text(
                  "Credit: ",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                Text(
                  data["credit"].toString().trim(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  "Debit: ",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                Text(
                  data["debit"].toString().trim(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Balance: ${data["running_balance"].toString().trim()}",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
