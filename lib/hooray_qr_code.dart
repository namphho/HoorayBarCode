import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'package:barcode_flutter/barcode_flutter.dart';

class HoorayBarCode extends StatelessWidget {
  String title;
  String content;
  HoorayBarCode({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                children: <Widget>[
                  Text(this.title, style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Center(child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    heightFactor: 0.38,
                    widthFactor: 0.87,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.84,
                      height: MediaQuery.of(context).size.height * 0.48,
                      child: Container(
                        color: Colors.grey[700],
                        child: RotatePinWheel(
                          key: UniqueKey(),),
                      ),
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8 * 0.9,
                    height: MediaQuery.of(context).size.height * 0.18 * 0.98,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25 * 0.25,
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: new BarCodeImage(
                        barHeight: 80,
                        lineWidth: 1.2,
                        data: this.content,
                        // Code string. (required) //1562165461408
                        codeType: BarCodeType.Code128,
                        // Code type (required)
                        hasText: true,
                        // Render with text label or not (default: false)
                        onError: (error) {
                          // Error handler
                          print('error = $error');
                        },
                      ),
                    )),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}

class RotatePinWheel extends StatefulWidget {

  const RotatePinWheel({
    Key key,
  }) : super(key: key);

  @override
  _RotatePinWheelState createState() => _RotatePinWheelState();
}

class _RotatePinWheelState extends State<RotatePinWheel>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 3),
    );
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new AnimatedBuilder(
          animation: animationController,
          child: PinWheel(
            color: Colors.white,
          ),
          builder: (BuildContext context, Widget _widget) {
            return Transform.rotate(
                angle: (animationController.value * math.pi), child: _widget);
          }),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class PinWheel extends StatelessWidget {
  final Color color;

  const PinWheel({
    this.color = Colors.grey,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: PinwheelPainter(
          color: color,
        ),
      ),
    );
  }
}

class PinwheelPainter extends CustomPainter {
  final Color color;

  const PinwheelPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final offset = Offset((size.width / 2), size.height / 2);
    Rect rect = new Rect.fromCircle(
        center: offset, radius: math.min((size.width / 2), (size.height / 2)));
    canvas.drawArc(rect, 0, math.pi/2, true, Paint()..color = color);
    canvas.drawArc(rect, math.pi, math.pi/2, true, Paint()..color = color);
  }

  @override
  bool shouldRepaint(PinwheelPainter oldDelegate) {
    return color == oldDelegate.color;
  }
}

