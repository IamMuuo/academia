import 'package:academia/exports/barrel.dart';
import 'package:lottie/lottie.dart';
import '../models/models.dart';

class SemesterEventView extends StatelessWidget {
  const SemesterEventView({
    super.key,
    required this.semester,
  });
  final Semester semester;
  static SemesterService ss = SemesterService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            pinned: true,
            floating: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Semester details"),
              background: Container(
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.zero, //.all(12),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Ionicons.extension_puzzle),
                    title: const Text(
                      "Semester name",
                    ),
                    subtitle: Text(
                      semester.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.code_slash_sharp),
                    title: const Text(
                      "Semester code",
                    ),
                    subtitle: Text(
                      semester.code,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.calendar),
                    title: const Text(
                      "Start date",
                    ),
                    subtitle: Text(
                      formatDateTime(semester.startDate),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.today),
                    title: const Text(
                      "End date",
                    ),
                    subtitle: Text(
                      formatDateTime(semester.endDate),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Semester events",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          SliverFillRemaining(
            child: FutureBuilder(
              future: ss.fetchSemesterEvent(semester.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return snapshot.data!.fold(
                    (l) => SingleChildScrollView(
                          child: Column(
                            children: [
                              Lottie.asset("assets/lotties/error.json"),
                              const SizedBox(height: 12),
                              Text(
                                "Holy .. $l",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ), (r) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = r[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text((index + 1).toString()),
                          ),
                          title: Text(data.name),
                          trailing: Icon(
                            data.endDate.isBefore(DateTime.now())
                                ? Ionicons.checkmark_done_circle
                                : Ionicons.chevron_up_circle_outline,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Starts: ${formatDateTime(data.startDate)}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Ends: ${formatDateTime(data.endDate)}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                      itemCount: r.length);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
