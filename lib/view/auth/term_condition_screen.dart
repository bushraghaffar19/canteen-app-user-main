import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermAndConditions extends StatelessWidget {
  const TermAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions",style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text("Title 1",style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),),
              const SizedBox(height: 10,),
              Text("Lörem ipsum nyn trinera mikrod predesk kode decide. Bepinde semimurade i homonas. Gotoktig disam dias spegode i legga dediktisk om än tosk. Infratevis miness megasat EU-migrant medan eurorissa pyv jag dopire. Isongar der fast gusade kaning. Trende bev bessade, kros tor och peskapet och osk i tinde. Tenihet kvasiren ode. Mure nev cynmani.",style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: kLightGreyColor
              ),),
              const SizedBox(height: 20,),
              Text("Title 2",style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),),
              const SizedBox(height: 10,),
              Text("Lörem ipsum nyn trinera mikrod predesk kode decide. Bepinde semimurade i homonas. Gotoktig disam dias spegode i legga dediktisk om än tosk. Infratevis miness megasat EU-migrant medan eurorissa pyv jag dopire. Isongar der fast gusade kaning. Trende bev bessade, kros tor och peskapet och osk i tinde. Tenihet kvasiren ode. Mure nev cynmani.",style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: kLightGreyColor
              ),),
              const SizedBox(height: 20,),
              Text("Title 3",style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),),
              const SizedBox(height: 10,),
              Text("Lörem ipsum nyn trinera mikrod predesk kode decide. Bepinde semimurade i homonas. Gotoktig disam dias spegode i legga dediktisk om än tosk. Infratevis miness megasat EU-migrant medan eurorissa pyv jag dopire. Isongar der fast gusade kaning. Trende bev bessade, kros tor och peskapet och osk i tinde. Tenihet kvasiren ode. Mure nev cynmani.",style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: kLightGreyColor
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
