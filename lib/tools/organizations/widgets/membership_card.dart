import 'package:academia/exports/barrel.dart';
import 'package:google_fonts/google_fonts.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({
    super.key,
    required this.membership,
  });
  final Membership membership;

  Color? _cardColor(Membership membership) {
    switch (membership.role) {
      case "member":
        return Colors.transparent;
      case "premium":
        return Colors.teal[100];
      case "administrator":
        return Colors.amber;
      default:
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor(membership),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).colorScheme.shadow,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(12),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: 232,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: membership.organization.logo!,
                height: 40,
              ),
              const Spacer(),
              Text(
                membership.role.title(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                    ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "${membership.user.firstName.title()}  ${membership.user.lastName.title()}",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(
                flex: 1,
                child: ProfilePictureWidget(
                  profileSize: 30,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Membership ID: ",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.jetBrainsMono().fontFamily,
                                  ),
                        ),
                        Text(
                          membership.id.toString(),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontFamily:
                                        GoogleFonts.jetBrainsMono().fontFamily,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "Organization: ",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.jetBrainsMono().fontFamily,
                                  ),
                        ),
                        Text(
                          membership.organization.name,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontFamily:
                                        GoogleFonts.jetBrainsMono().fontFamily,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      membership.id.toString(),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                GoogleFonts.libreBarcode128().fontFamily,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          Text(
            "The above is a member of the ${membership.organization.name} group",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.red, overflow: TextOverflow.fade),
          ),
        ],
      ),
    );
  }
}
