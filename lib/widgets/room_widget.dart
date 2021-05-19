import 'package:flutter/material.dart';
import 'package:traktir_davl/screens/main_screen.dart';

class RoomWidget extends StatefulWidget {
  @override
  _RoomWidgetState createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<RoomWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://sun9-20.userapi.com/impf/c840730/v840730051/89e61/flmC0EOQVL4.jpg?size=1280x853&quality=96&sign=5922901ba56ae34e75230d6d2edd1b6a&type=album',
          fit: BoxFit.cover,
        ),
        Positioned(
            top: 150,
            left: 50,
            child: ClipOval(
                child: Material(
                  color: Colors.white, // button color
                  child: InkWell(
                    splashColor: Colors.grey[700], // inkwell color
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Container(
                          padding: EdgeInsets.only(top: 13),
                          child: Text(
                            'Free!',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                  ),
                ),
            )),
        Positioned(
            top: 120,
            left: 180,
            child: ClipOval(
              child: Material(
                color: Colors.white, // button color
                child: InkWell(
                  splashColor: Colors.grey[700], // inkwell color
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Container(
                      padding: EdgeInsets.only(top: 13),
                      child: Text(
                        'Free!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  },
                ),
              ),
            )),
      ],
    );
  }
}
