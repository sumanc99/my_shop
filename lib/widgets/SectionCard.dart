// importing the material components and designs
import 'package:flutter/material.dart';

class Sectioncard extends StatelessWidget{

  final IconData icon; //hold the icon of a particular section
  final String text; // hold the text of a particular section
  final VoidCallback onTap; // hold a function

  // constructure and what it take
  const Sectioncard(
    {
      super.key, 
      required this.icon,
      required this.text,
      required this.onTap,
    }
    );
    // creating a widget of the stateless class
    @override
    Widget build(BuildContext context){
      // returning an expanded child
      return Expanded(
        // holding gesture detector as a child
        child:GestureDetector(
          // way of detecting when user tap the section
          onTap: onTap,
          // card that contain the section icon and text
          child: Card(
            // a bit of shadow for the card
            elevation: 4.0,
            // give the card a rectangular look and some curve border
            shape: RoundedRectangleBorder(
              // the size of the border curve
              borderRadius: BorderRadius.circular(12.0),
            ),
            // the content that the card hold as a child
            // also the content will be center
            child: Center(
              // what the is being centered
              // put the content in a column
              child: Column(
                // put all the content in the center of it axis
                mainAxisAlignment: MainAxisAlignment.center,
                // now the content as children of column
                children: [
                  Icon(
                    icon,
                    size: 100.0,
                    color: Colors.black54,
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      // color: Colors.black54,
                    ),
                    ),
                ],
              )
            ),
          ),
        ),
      );
    }





}