import 'package:academia/exports/barrel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import '../pages/pages.dart';
import '../models/models.dart';

class SemesterPage extends StatelessWidget {
  SemesterPage({super.key});
  final SemesterService ss = SemesterService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ss.fetchAllSemesters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Column(
              children: [
                Lottie.asset("assets/lotties/loading.json"),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Fetching available semesters",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return Column(
              children: [
                Lottie.asset("assets/lotties/error.json"),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "We ran into a problem loading pages",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            );
          }

          return snapshot.data!.fold((l) {
            return Column(
              children: [
                Lottie.asset("assets/lotties/error.json"),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Jeez: $l",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            );
          }, (r) {
            if (r.isEmpty) {
              return Column(
                children: [
                  Lottie.asset("assets/lotties/empty.json"),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "No semesters are in session please try again later",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              );
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                final data = r[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SemesterEventView(semester: data),
                      ),
                    );
                  },
                  title: Text(data.name),
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                  ),
                  subtitle: Text(
                    "Code: ${data.code}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: const Icon(Ionicons.arrow_redo_outline),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4);
              },
              itemCount: r.length,
            );
          });
        });
  }
}
