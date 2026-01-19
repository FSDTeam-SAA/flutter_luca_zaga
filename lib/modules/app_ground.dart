import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/core/image_path.dart';
import 'package:flutter_luca_zaga30/modules/home/presentation/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

class AppGround extends StatefulWidget {
  const AppGround({super.key});

  @override
  State<AppGround> createState() => _AppGroundState();
}

class _AppGroundState extends State<AppGround> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // or C.bg
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImagePath.backgroundIcon,
            ), // 🔹 use your asset here
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                HeaderSection(),
                SizedBox(height: 16),
                StatsRow(),
                SizedBox(height: 12),
                RentalIncomeCard(),
                SizedBox(height: 16),
                CashFlowCard(),
                SizedBox(height: 16),
                UpcomingPaymentsSection(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _BottomNavBar(
        currentIndex: _currentIndex,
        onChanged: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            BOTTOM NAVIGATION BAR                           */
/* -------------------------------------------------------------------------- */

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentIndex, required this.onChanged});

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.only(top: 6),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onChanged,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: C.primary,
        unselectedItemColor: C.textMuted,
        selectedLabelStyle: GoogleFonts.roboto(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 22,
              height: 22,
              child: Image.asset(
                ImagePath.homeIcon,
                fit: BoxFit.contain,
                color: Colors.white, // remove if your PNG is already colored
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 22,
              height: 22,
              child: Image.asset(
                ImagePath.notificationIcon,
                fit: BoxFit.contain,
                color: Colors.white, // remove if your PNG is already colored
                colorBlendMode: BlendMode.srcIn,
              ),
            ),

            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 22,
              height: 22,
              child: Image.asset(
                ImagePath.portfolioIcon,
                fit: BoxFit.contain,
                color: Colors.white, // remove if your PNG is already colored
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 22,
              height: 22,
              child: Image.asset(
                ImagePath.cashIcon,
                fit: BoxFit.contain,
                color: Colors.white, // remove if your PNG is already colored
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            label: 'Cashflow',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 22,
              height: 22,
              child: Image.asset(
                ImagePath.userIcon,
                fit: BoxFit.contain,
                color: Colors.white, // remove if your PNG is already colored
                colorBlendMode: BlendMode.srcIn,
              ),
            ),

            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
