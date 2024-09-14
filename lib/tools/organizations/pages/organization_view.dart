import 'package:academia/exports/barrel.dart';
import 'package:flutter_html/flutter_html.dart';

class OrganizationView extends StatelessWidget {
  const OrganizationView({
    super.key,
    required this.organization,
  });
  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(organization.name),
              background: organization.banner == null
                  ? Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                    )
                  : CachedNetworkImage(
                      imageUrl: organization.banner!,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: CircleAvatar(
                radius: 60,
                child: CachedNetworkImage(
                  imageUrl: organization.logo!,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              leading: const Icon(Ionicons.mail_outline),
              title: Text(organization.email),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              leading: const Icon(Ionicons.phone_portrait_outline),
              title: Text(organization.phone),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              leading: const Icon(Ionicons.locate),
              title: Text(organization.location),
            ),
          ),
          SliverVisibility(
            visible: !(organization.organizationPage == null),
            sliver: SliverToBoxAdapter(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WebviewPage(
                          title: "Organization",
                          url: organization.organizationPage!)));
                },
                title: const Text("Visit organization's site"),
                leading: const Icon(Ionicons.link_outline),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              title: Text(
                "Organization Description",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Html(data: organization.description ?? "<html></html>"),
            ),
          ),
        ],
      ),
    );
  }
}
