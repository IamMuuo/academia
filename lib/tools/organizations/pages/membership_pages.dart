import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/organizations/widgets/membership_card.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:get/get.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  final UserController userController = Get.find<UserController>();
  late Future<dartz.Either<String, List<Membership>>> _loader;
  final OrganizationService _service = OrganizationService();

  @override
  void initState() {
    super.initState();
    _loader = _service.fetchUserMemberships(
        userController.user.value?.id ?? '', userController.authHeaders);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _loader = _service.fetchUserMemberships(
              userController.user.value?.id ?? '', userController.authHeaders);
          setState(() {});
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Your memberships"),
                background: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: SchoolIDCard(
                  user: userController.user.value!,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverFillRemaining(
                hasScrollBody: true,
                child: FutureBuilder(
                  future: _loader,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Text("Loading memberships");
                    }

                    return snapshot.data!.fold((l) {
                      return Center(child: Text("Arg .. $l"));
                    }, (r) {
                      return ListView.separated(
                          itemBuilder: (context, index) => MembershipCard(
                                membership: r[index],
                              ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 2),
                          itemCount: r.length);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
