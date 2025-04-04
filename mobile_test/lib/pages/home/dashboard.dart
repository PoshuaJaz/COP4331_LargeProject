import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../styles.dart';
import 'dart:async';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

// countdown timer widget
class CountdownTimer extends StatefulWidget {
  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {

  // set date : the first saturday of the summer semester
  late Timer _timer;
  late Duration _remaining;
  final DateTime _targetDate = DateTime(2025, 5, 17);

  // update time every one seconds
  @override
  void initState() {
    super.initState();
    _updateTime();

    _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    final diff = _targetDate.difference(now);

    setState(() {
      _remaining = diff.isNegative ? Duration.zero : diff;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timeBox(days, 'DAYS'),
        _spacer(),
        _timeBox(hours, 'HOURS'),
        _spacer(),
        _timeBox(minutes, 'MINUTES'),
        _spacer(),
        _timeBox(seconds, 'SECONDS'),
      ],
    );
  }

  // style
  Widget _timeBox(int time, String label) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: '$time\n', style: Styles.timeTextStyle),
          TextSpan(text: label, style: Styles.timeLabelTextStyle),
        ],
      ),
    );
  }

  Widget _spacer() => SizedBox(width: 15);
}

class _DashboardPageState extends State<DashboardPage> {
  
  String bullet = '\u2022';

  @override
  Widget build(BuildContext context) {
    double scrnWidth = MediaQuery.of(context).size.width;
    double containerWidth = (scrnWidth- 65);

    return Center(
      child: ListView(
        children: <Widget>[
          //Container for heading timer section
          Container(
            width: 412,
            height: 152,
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
                boxShadow: [BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 5,
                  spreadRadius: 5,
                  color: Colors.grey.shade400,
                )],
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0),

            child: Column( spacing: 15.0, children: <Widget>[
              //header for timer
              RichText(
              textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'The Foundation Exam is in...',
                  style: Styles.timeLabelTextStyle,
                ),
              ),
              //timer
              CountdownTimer(),
            ],),
          ),
          //header for guidelines
          Container(
            padding: EdgeInsets.fromLTRB(10, 35, 10, 0),
            child: Text(
              'Foundation Exam Guideline',
              textAlign: TextAlign.center,
              style: Styles.timeTextStyle,
            ),
          ),
          //container for all guideline bullets
          Container(
            width: scrnWidth,
            padding: EdgeInsets.all(20.0),
            child: Column(spacing: 10, children: [
              //Purpose Bullet
              Row(spacing: 5, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(bullet, style: Styles.generalTextStyle,),
                Container(width: containerWidth, padding: EdgeInsets.symmetric(horizontal: 5), child:
                  Text('Purpose: Required exam for 4000-level CS courses', style: Styles.generalTextStyle,)
              )]),
              //Eligibility bullet
              Row(spacing: 5, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(bullet, style: Styles.generalTextStyle,),
                Container(width: containerWidth, padding: EdgeInsets.symmetric(horizontal: 5), child:
                  Text('Eligibility: Students who passed COP 3502 (C or higher)', style: Styles.generalTextStyle,)
              )]),
              //Attempts Bullet
              Row(spacing: 5, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(bullet, style: Styles.generalTextStyle,),
                Container(width: containerWidth, padding: EdgeInsets.symmetric(horizontal: 5), child:
                  Text('Attempts: Max 3 attempts within 1 year', style: Styles.generalTextStyle,)
              )]),
              //Schedule Bullet
              Row(spacing: 5, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(bullet, style: Styles.generalTextStyle,),
                Container(width: containerWidth, padding: EdgeInsets.symmetric(horizontal: 5), child:
                  Text('Schedule: First Saturday of each semester', style: Styles.generalTextStyle,)
              )]),
              //Registration Bullet
              Row(spacing: 5, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(bullet, style: Styles.generalTextStyle,),
                Container(width: containerWidth, padding: EdgeInsets.symmetric(horizontal: 5), child:
                  RichText(text: TextSpan(children: [
                    TextSpan(
                      text: 'Registration: ',
                      style: Styles.generalTextStyle,
                    ),
                    TextSpan(
                      text: 'Register here',
                      style: Styles.linkTextStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () { launchUrlString('https://www.cs.ucf.edu/registration/new/index.php');},
                    ),
                ])),
              )]),
              //Allowed Materials Bullet
              Row(spacing: 5, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(bullet, style: Styles.generalTextStyle,),
                Container(width: containerWidth, padding: EdgeInsets.symmetric(horizontal: 5), child:
                  RichText(text: TextSpan(children: [
                    TextSpan(
                      text: 'Allowed Materials: ',
                      style: Styles.generalTextStyle,
                    ),
                    TextSpan(
                      text: 'Formula Sheet',
                      style: Styles.linkTextStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () { launchUrlString('https://www.cs.ucf.edu/wp-content/uploads/2019/08/FE-FormulaSheet.pdf');},
                    ),
                  ])),
              )]),
              //Exam Day rules bullets
              Row(spacing: 5, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(bullet, style: Styles.generalTextStyle,),
                Container(width: containerWidth, padding: EdgeInsets.symmetric(horizontal: 5), child:
                  RichText( text: TextSpan(
                    style: Styles.generalTextStyle,
                    text: 'Exam Day Rules\n'
                           '\t$bullet Bring valid ID\n'
                           '\t$bullet No electronic devices\n'
                           '\t$bullet Time limit enforced'
                  )),
              )]),
              //Passing criteria bullet
              Row(spacing: 5, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(bullet, style: Styles.generalTextStyle,),
                Container(width: containerWidth, padding: EdgeInsets.symmetric(horizontal: 5), child:
                  Text('Passing Criteria: Typically 60% or higher', style: Styles.generalTextStyle,)
              )]),
              //More info bullet
              Row(spacing: 5, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(bullet, style: Styles.generalTextStyle,),
                Container(width: containerWidth, padding: EdgeInsets.symmetric(horizontal: 5), child:
                RichText(text: TextSpan(children: [
                  TextSpan(
                    text: 'More Info: ',
                    style: Styles.generalTextStyle,
                  ),
                  TextSpan(
                    text: 'Official Site',
                    style: Styles.linkTextStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () { launchUrlString('https://www.cs.ucf.edu/ucf_section/foundation-exam/');},
                  ),
                ])),
              )]),
              //Bottom whitespace
              SizedBox(height: 100)
            ]),
          ),
        ],
      )
    );
  }
}
