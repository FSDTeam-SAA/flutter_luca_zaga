import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/core/image_path.dart';
import 'package:flutter_luca_zaga30/modules/home/presentation/screens/home.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingPaymentScreen extends StatelessWidget {
  const UpcomingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // bg comes from the image now
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImagePath.backgroundIcon, // 🔹 your background asset
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),

              /// ---------- Custom AppBar ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _HeaderIconButton(
                      icon: Icons.arrow_back,
                      onTap: () => Get.back(),
                    ),
                    Expanded(
                      child: Text(
                        'Upcoming Payment',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: C.textMain,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _HeaderIconButton(
                          icon: Icons.add,
                          onTap: () {
                            // TODO: add new payment
                          },
                        ),
                        const SizedBox(width: 8),
                        _HeaderIconButton(
                          icon: Icons.filter_alt_outlined,
                          onTap: () {
                            // TODO: open filter bottom sheet
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// ---------- List of payment cards ----------
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: dummyPayments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = dummyPayments[index];
                    return _PaymentCard(
                      icon: item.icon,
                      title: item.title,
                      subtitle: item.subtitle,
                      amount: item.amount,
                      date: item.date,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final String date;

  const PaymentItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
  });
}

const List<PaymentItem> dummyPayments = [
  PaymentItem(
    icon: Icons.email_outlined,
    title: 'Home payment',
    subtitle: 'for Apt. 3',
    amount: '\$2,400',
    date: 'Mar 1',
  ),
  PaymentItem(
    icon: Icons.email_outlined,
    title: 'Home payment',
    subtitle: 'for Apt. 7',
    amount: '\$2,400',
    date: 'Mar 1',
  ),
  PaymentItem(
    icon: Icons.receipt_long_outlined,
    title: 'Bill',
    subtitle: 'for Apt. 21',
    amount: '\$2,400',
    date: 'Mar 1',
  ),
  PaymentItem(
    icon: Icons.email_outlined,
    title: 'Home payment',
    subtitle: 'for Apt. 3',
    amount: '\$2,400',
    date: 'Mar 1',
  ),
  PaymentItem(
    icon: Icons.receipt_long_outlined,
    title: 'Bill',
    subtitle: 'for Apt. 21',
    amount: '\$2,400',
    date: 'Mar 1',
  ),
  PaymentItem(
    icon: Icons.vpn_key_rounded,
    title: 'Mortgage Payment',
    subtitle: 'for Apt. 7',
    amount: '\$2,400',
    date: 'Mar 1',
  ),
  PaymentItem(
    icon: Icons.apartment_outlined,
    title: 'Sunset Apartments',
    subtitle: 'Rent Due',
    amount: '\$2,400',
    date: 'Mar 1',
  ),
  PaymentItem(
    icon: Icons.vpn_key_rounded,
    title: 'Mortgage Payment',
    subtitle: 'for Apt. 7',
    amount: '\$2,400',
    date: 'Mar 1',
  ),
  PaymentItem(
    icon: Icons.vpn_key_rounded,
    title: 'Mortgage Payment',
    subtitle: 'for Apt. 7',
    amount: '\$2,400',
    date: 'Mar 1',
  ),
];

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0x6606050A), // #06050A 40%
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: const Color(0xFF929292), // approx gradient border
        ),
      ),
      child: Row(
        children: [
          // leading icon
          Container(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),

          // title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: C.textMain,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.roboto(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: C.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // amount + date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: C.textMain,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: GoogleFonts.roboto(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: C.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Small square buttons in header (+, filter, back)
class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0x6606050A), // #06050A 40%
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            // Figma border is gradient; we approximate with a mid grey
            color: const Color(0xFF929292),
          ),
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}
