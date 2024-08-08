import 'package:academia/exports/barrel.dart';
import 'package:flutter/material.dart';

class PersistentStorySliverDelegate extends SliverPersistentHeaderDelegate {
  PersistentStorySliverDelegate({
    required this.child,
    this.numberofStories = 5,
  });
  final Widget child;
  int numberofStories;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const CircleAvatar(
            radius: 45,
          );
        },
        itemCount: numberofStories,
        separatorBuilder: (context, index) => const SizedBox(width: 4),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  @override
  double get maxExtent => 120.0; // Height of the header

  @override
  double get minExtent => 100.0; // Height of the header when scrolled

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
