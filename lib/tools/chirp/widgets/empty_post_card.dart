import 'package:academia/exports/barrel.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EmptyPostCard extends StatelessWidget {
  const EmptyPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                ),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      height: 10,
                      width: 60,
                    ),
                    const SizedBox(height: 2),
                    Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      height: 10,
                      width: 120,
                    ),
                  ],
                ),
                const Spacer(),
                const CircleAvatar(radius: 10)
              ],
            ),
            const SizedBox(height: 4),
            Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              height: 60,
              width: double.infinity,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  height: 20,
                  width: 60,
                ),
                const Spacer(),
                Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  height: 20,
                  width: 60,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
