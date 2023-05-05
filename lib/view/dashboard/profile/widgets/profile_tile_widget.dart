import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const ProfileTileWidget({
    required this.icon,
    required this.onTap,
    required this.title,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.iconTheme.color,
              size: 25,
            ),
            const SizedBox(width: 25,),
            Text(title, style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: theme.iconTheme.color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
