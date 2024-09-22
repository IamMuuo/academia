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
  @override
  bool get wantKeepAlive => true;

  final OrganizationService _service = OrganizationService();

  // TH loading state
  late Future<dartz.Either<String, List<Organization>>> _loader;

  @override
  void initState() {
    super.initState();
    _loader = _service.fetchOrganizations(userController.authHeaders);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        _loader = _service.fetchOrganizations(userController.authHeaders);
        setState(() {});
      },
      child: FutureBuilder(
        future: _loader,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Text("loading");
          }

          return snapshot.data!.fold((l) {
            return Center(
              child: Text("Holly .. $l"),
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
