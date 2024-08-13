import 'package:flutter/material.dart';
import 'package:academia/tools/anki/widgets/widgets.dart';

class StarredTopics extends StatelessWidget {
  const StarredTopics({
    super.key,
    required this.topic,
    required this.desc,
  });

  final String topic;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width * 0.87,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Positioned(
            top: 9,
            left: 3,
            right: 4,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.267,
              decoration: const BoxDecoration(
                color: Color(0xffe5ffcd),
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Topic",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(topic),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(desc),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 9,
            right: 5,
            left: 150,
            child: Container(
              height: 95,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff444c55),
                    width: 10,
                    style: BorderStyle.solid,
                  ),
                  left: BorderSide(
                    color: Color(0xff444c55),
                    width: 10,
                    style: BorderStyle.solid,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(500),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 19,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => debugPrint("Feature Coming Real Soon"),
                    child: Icon(
                      Icons.play_arrow,
                      size: MediaQuery.of(context).size.height * 0.041,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => debugPrint("Feature Coming Real Soon"),
                    child: Icon(
                      Icons.star_border_outlined,
                      size: MediaQuery.of(context).size.height * 0.035,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 10,
            left: 16,
            child: CustomEclipse(),
          ),
        ],
      ),
    );
  }
}
