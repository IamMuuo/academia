import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/widgets/widgets.dart';
import 'package:get/get.dart';

class AnkiHomePage extends StatelessWidget {
  const AnkiHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Starred Topics",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.27,
              width: MediaQuery.of(context).size.width * 0.87,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, idx) {
                  return listStarred[idx];
                },
                itemCount: 5,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => debugPrint("Feature Coming Real Soon"),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                child: const Text(
                  "Create Topic",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.53,
            decoration: BoxDecoration(
              color: lightColorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, idx) {
                  return test_topics[idx];
                },
                itemCount: test_topics.length,
                scrollDirection: Axis.vertical,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
