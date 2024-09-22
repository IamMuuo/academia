import 'package:academia/exports/barrel.dart';
import '../pages/organization_view.dart';

class OrganizationCard extends StatelessWidget {
  const OrganizationCard({
    super.key,
    required this.organization,
  });
  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OrganizationView(
              organization: organization,
            ),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          organization.logo ?? "",
        ),
      ),
      title: Text(organization.name),
      subtitle: Text(organization.email),
      trailing: const Icon(Ionicons.arrow_forward_outline),
    );
  }
}
