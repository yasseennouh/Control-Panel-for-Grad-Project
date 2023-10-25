import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_blue_app/utils.dart';

class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // iphone11promax1eBk (0:147)
        width: double.infinity,
        height: 896*fem,
        decoration: BoxDecoration (
          color: Color(0xfff8f8f8),
          borderRadius: BorderRadius.circular(50*fem),
          boxShadow: [
            BoxShadow(
              color: Color(0xff3e3e3e),
              offset: Offset(4*fem, 4*fem),
              blurRadius: 4.5*fem,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              // rectangle26J1Q (30:907)
              left: 0*fem,
              top: 74*fem,
              child: Align(
                child: SizedBox(
                  width: 414*fem,
                  height: 790*fem,
                  child: Container(
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(50*fem),
                      color: Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          offset: Offset(0*fem, 4*fem),
                          blurRadius: 2*fem,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // groupZxv (30:978)
              left: 28.0000305176*fem,
              top: 183*fem,
              child: Align(
                child: SizedBox(
                  width: 325.26*fem,
                  height: 209.86*fem,
                  child: Image.asset(
                    'assets/page-1/images/group-DTY.png',
                    width: 325.26*fem,
                    height: 209.86*fem,
                  ),
                ),
              ),
            ),
            Positioned(
              // splashscreendC6 (8:368)
              left: 0*fem,
              top: 0*fem,
              child: Container(
                width: 414*fem,
                height: 896*fem,
                decoration: BoxDecoration (
                  color: Color(0xff211f67),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      // bgYZx (8:369)
                      left: 0*fem,
                      top: 16*fem,
                      child: Align(
                        child: SizedBox(
                          width: 1032*fem,
                          height: 975.8*fem,
                          child: Image.asset(
                            'assets/page-1/images/bg.png',
                            width: 1032*fem,
                            height: 975.8*fem,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // backdroppnN (8:377)
                      left: 0*fem,
                      top: 324*fem,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(35*fem, 63*fem, 16*fem, 80*fem),
                        width: 414*fem,
                        height: 572*fem,
                        decoration: BoxDecoration (
                          image: DecorationImage (
                            fit: BoxFit.cover,
                            image: AssetImage (
                              'assets/page-1/images/backdrop-base-a4A.png',
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // pageheader4wc (9:398)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 20*fem, 35*fem),
                              padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 49*fem, 0*fem),
                              width: double.infinity,
                              height: 45*fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // autogroupaoppmb8 (J5WiHKAEKPQri5oE2QAoPp)
                                    margin: EdgeInsets.fromLTRB(0*fem, 8*fem, 12*fem, 17*fem),
                                    width: 40*fem,
                                    height: double.infinity,
                                  ),
                                  Text(
                                    // signupHpN (I9:398;144:2323)
                                    'Welcome Back!',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont (
                                      'Poppins',
                                      fontSize: 30*ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.5*ffem/fem,
                                      color: Color(0xff424242),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // phoneoGv (8:390)
                              margin: EdgeInsets.fromLTRB(9*fem, 0*fem, 0*fem, 32.54*fem),
                              width: 354*fem,
                              height: 44.46*fem,
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(20*fem),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    // idiPt (8:391)
                                    left: 20*fem,
                                    top: 14.5350952148*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 17*fem,
                                        height: 19*fem,
                                        child: Text(
                                          'ID',
                                          style: SafeGoogleFont (
                                            'Montserrat',
                                            fontSize: 15*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175*ffem/fem,
                                            letterSpacing: -0.3000000119*fem,
                                            color: Color(0xffc0c0c0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // rectangle5awt (8:392)
                                    left: 0*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 354*fem,
                                        height: 44.46*fem,
                                        child: Container(
                                          decoration: BoxDecoration (
                                            borderRadius: BorderRadius.circular(20*fem),
                                            border: Border.all(color: Color(0xffc0c0c0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // passVJA (8:393)
                              margin: EdgeInsets.fromLTRB(9*fem, 0*fem, 0*fem, 21.54*fem),
                              width: 354*fem,
                              height: 44.46*fem,
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(20*fem),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    // passwordo3x (8:394)
                                    left: 20*fem,
                                    top: 14*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 70*fem,
                                        height: 19*fem,
                                        child: Text(
                                          'Password',
                                          style: SafeGoogleFont (
                                            'Montserrat',
                                            fontSize: 15*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175*ffem/fem,
                                            letterSpacing: -0.3000000119*fem,
                                            color: Color(0xffc0c0c0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // rectangle5Uvn (8:395)
                                    left: 0*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 354*fem,
                                        height: 44.46*fem,
                                        child: Container(
                                          decoration: BoxDecoration (
                                            borderRadius: BorderRadius.circular(20*fem),
                                            border: Border.all(color: Color(0xffc0c0c0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // buttonprimaryc1Q (8:396)
                              margin: EdgeInsets.fromLTRB(14*fem, 0*fem, 6*fem, 21.39*fem),
                              padding: EdgeInsets.fromLTRB(138*fem, 16*fem, 138*fem, 3.61*fem),
                              width: double.infinity,
                              decoration: BoxDecoration (
                                color: Color(0xff211f67),
                                borderRadius: BorderRadius.circular(100*fem),
                              ),
                              child: Text(
                                'Confirm',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont (
                                  'Poppins',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5*ffem/fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            Container(
                              // forgotyourpasswordG5x (9:416)
                              margin: EdgeInsets.fromLTRB(9*fem, 0*fem, 0*fem, 20*fem),
                              child: Text(
                                'Forgot your password?',
                                style: SafeGoogleFont (
                                  'Montserrat',
                                  fontSize: 15*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2175*ffem/fem,
                                  letterSpacing: -0.3000000119*fem,
                                  color: Color(0xff063eab),
                                ),
                              ),
                            ),
                            Container(
                              // autogroupx2eemHc (J5WhvVRbNfcCNsUfENX2Ee)
                              margin: EdgeInsets.fromLTRB(38*fem, 0*fem, 29*fem, 27*fem),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // line5gvN (9:411)
                                    margin: EdgeInsets.fromLTRB(0*fem, 4*fem, 8*fem, 0*fem),
                                    width: 130*fem,
                                    height: 1*fem,
                                    decoration: BoxDecoration (
                                      color: Color(0xffafafaf),
                                    ),
                                  ),
                                  Container(
                                    // or2DY (9:412)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 10*fem, 0*fem),
                                    child: Text(
                                      'Or',
                                      style: SafeGoogleFont (
                                        'Montserrat',
                                        fontSize: 15*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2175*ffem/fem,
                                        letterSpacing: -0.3000000119*fem,
                                        color: Color(0xffc0c0c0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // line6KiS (9:413)
                                    margin: EdgeInsets.fromLTRB(0*fem, 4*fem, 0*fem, 0*fem),
                                    width: 130*fem,
                                    height: 1*fem,
                                    decoration: BoxDecoration (
                                      color: Color(0xffb3b3b3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // buttonprimaryTJr (9:414)
                              margin: EdgeInsets.fromLTRB(14*fem, 0*fem, 6*fem, 0*fem),
                              width: double.infinity,
                              height: 56*fem,
                              decoration: BoxDecoration (
                                border: Border.all(color: Color(0xff211f67)),
                                borderRadius: BorderRadius.circular(100*fem),
                              ),
                              child: Center(
                                child: Text(
                                  'Register',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5*ffem/fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // pngegg1hiz (8:389)
              left: 17*fem,
              top: 0*fem,
              child: Align(
                child: SizedBox(
                  width: 380*fem,
                  height: 322*fem,
                  child: Image.asset(
                    'assets/page-1/images/pngegg-1-7fG.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
          );
  }
}