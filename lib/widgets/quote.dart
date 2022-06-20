import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({Key? key, required this.quote, required this.author})
      : super(key: key);
  final quote;
  final author;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(
            flex: 2,
          ),
          Image.asset(
            "assets/quote.png",
            height: 30,
            width: 30,
            color: Colors.white,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            quote,
            style: GoogleFonts.lato(
              textStyle: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            author,
            style: GoogleFonts.lato(
              textStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
