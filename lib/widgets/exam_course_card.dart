import 'package:academia/constants/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExamCourseCard extends StatelessWidget {
  const ExamCourseCard({
    super.key,
    required this.ontap,
    required this.code,
    required this.date,
    required this.venue,
    required this.time,
  });
  final Function? ontap;
  final String code;
  final String date;
  final String venue;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          right: 2,
          child: IconButton(
            onPressed: () {
              ontap?.call();
            },
            icon: const Icon(
              CupertinoIcons.xmark_circle,
              color: Colors.redAccent,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    code,
                    // snapshot.data![index]["course_code"].toString(),
                    style: h6,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'Date: ',
                        style: h6,
                      ),
                      Text(
                        date,
                        // DateFormat('EEE dd/MM/yy').format(DateFormat('dd/MM/yy')
                        //     .parse(snapshot.data![index]["day"]
                        //         .toString()
                        //         .split(" ")[1])),
                        style: normal.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Venue: ',
                        style: h6,
                      ),
                      Text(
                        venue,
                        // snapshot.data![index]["room"].toString(),
                        style: normal.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'Time: ',
                        style: h6,
                      ),
                      Text(
                        time,
                        // snapshot.data![index]["time"].toString(),
                        style: normal.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
