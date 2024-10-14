import 'package:academia/exports/barrel.dart';
import '../widgets/widgets.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:get/get.dart';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage>
    with AutomaticKeepAliveClientMixin {
  final UserController userController = Get.find<UserController>();
  final OrganizationController organizationController =
      Get.find<OrganizationController>();
  @override
  bool get wantKeepAlive => true;

  // TH loading state
  late Future<dartz.Either<String, List<Organization>>> _loader;

  @override
  void initState() {
    super.initState();
    _loader =
        organizationController.fetchOrganizations(userController.authHeaders);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        _loader = organizationController
            .fetchOrganizations(userController.authHeaders);
        setState(() {});
      },
      child: FutureBuilder(
        future: _loader,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ListView.builder(
              itemBuilder: (context, index) => const ListTile(
                leading: CircleAvatar(),
                trailing: CircleAvatar(radius: 5),
              ),
            );
          }
          //
          // if (snapshot.hasError) {
          //   return const Center(
          //     child: Text("Error"),
          //   );
          // }

          return snapshot.data!.fold((l) {
            return Center(
              child: Text(
                "Holly .. $l",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            );
          }, (r) {
            return ListView.separated(
              itemBuilder: (context, index) => OrganizationCard(
                organization: r[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 2),
              itemCount: r.length,
            );
          });
        },
      ),
    );
  }
}
