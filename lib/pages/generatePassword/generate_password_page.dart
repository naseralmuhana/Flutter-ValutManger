import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/widgets/clipBoard/clip_board.dart';
import 'package:password_manager/widgets/form/components/custom_elevated_button.dart';

class GeneratePasswordPage extends StatefulWidget {
  static final String routeName = 'GeneratePasswordPageRoute';
  @override
  _GeneratePasswordPageState createState() => _GeneratePasswordPageState();
}

class _GeneratePasswordPageState extends State<GeneratePasswordPage> {
  bool isNumber = true;
  bool isLowerCase = true;
  bool isUpperCase = true;
  bool isSymbols = true;
  double length = 16;
  double sliderMin = 5;
  double sliderMax = 32;
  late String password;

  @override
  void initState() {
    password = generateRandomPassword(
      length: this.length.toInt(),
      includeLowerLetter: isLowerCase,
      includeNumber: isNumber,
      includeSymbol: isSymbols,
      includeUpperLetter: isUpperCase,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildScaffoldBody(),
    );
  }

  Widget buildScaffoldBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildContainerTitle(label: 'generated password'),
          buildContainer(content: password),
          SizedBox(height: 20.0),
          buildContainerTitle(label: 'length: ${length.toInt()}'),
          buildCustomCard(
            child: buildLengthSlider(),
          ),
          buildContainerTitle(label: 'Settings'),
          buildCustomCard(
            child: buildSwitchListTile(
              cardLabel: 'Include numbers',
              value: isNumber,
              onChanged: (val) => setState(() => isNumber = val),
            ),
          ),
          buildCustomCard(
            child: buildSwitchListTile(
              cardLabel: 'Include lowerCase letters',
              value: isLowerCase,
              onChanged: (val) => setState(() => isLowerCase = val),
            ),
          ),
          buildCustomCard(
            child: buildSwitchListTile(
              cardLabel: 'Include upperCase letters',
              value: isUpperCase,
              onChanged: (val) => setState(() => isUpperCase = val),
            ),
          ),
          buildCustomCard(
            child: buildSwitchListTile(
              cardLabel: 'Include symbols',
              value: isSymbols,
              onChanged: (val) => setState(() => isSymbols = val),
            ),
          ),
          SizedBox(height: 20.0),
          CustomElevatedButton(
            buttonLabel: 'Generate Password',
            onPressed: () {
              setState(() {
                password = generateRandomPassword(
                  length: this.length.toInt(),
                  includeLowerLetter: isLowerCase,
                  includeNumber: isNumber,
                  includeSymbol: isSymbols,
                  includeUpperLetter: isUpperCase,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Container buildCustomCard({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.5,
        vertical: kDefaultPadding * 0.2,
      ),
      padding: EdgeInsets.all(kDefaultPadding * 0.07),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  ListTile buildSwitchListTile({
    required String cardLabel,
    required bool value,
    required void Function(bool)? onChanged,
  }) {
    return ListTile(
      title: Text(
        cardLabel,
        style: TextStyle(fontSize: 17),
      ),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  SliderTheme buildLengthSlider() {
    return SliderTheme(
      data: SliderThemeData(
          thumbColor: Colors.white,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 13.0),
          trackHeight: 2,
          overlayColor: kPrimaryColorOpacity,
          activeTrackColor: kPrimaryColor,
          inactiveTrackColor: Colors.black54,
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.transparent,
          valueIndicatorColor: kCardColor),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Slider(
          min: sliderMin,
          max: sliderMax,
          value: length,
          divisions: sliderMax.toInt(),
          label: length.toInt().toString(),
          onChanged: (value) {
            setState(() {
              print(length);
              length = value;
            });
          },
        ),
      ),
    );
  }

  Widget buildContainer({required String content}) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding * 0.5),
      child: Container(
        height: 70.0,
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: FittedBox(
                child: Text(
                  content,
                ),
              ),
            ),
            SizedBox(width: 15),
            CustomClipBoard.buildCopyClipboard(
              value: password,
            ),
          ],
        ),
      ),
    );
  }

  Padding buildContainerTitle({required String label}) {
    return Padding(
      padding: EdgeInsets.only(
        top: kDefaultPadding,
        bottom: kDefaultPadding * 0.1,
        left: kDefaultPadding * 0.8,
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: Colors.white60,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Generate Password'),
      centerTitle: true,
    );
  }

  String generateRandomPassword({
    required int length,
    bool includeLowerLetter = true,
    bool includeUpperLetter = true,
    bool includeNumber = true,
    bool includeSymbol = true,
  }) {
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '0123456789';
    final symbol = '@#%^*>\$@?/[]=+';
    String chars = "";
    if (includeLowerLetter) chars += '$letterLowerCase';
    if (includeUpperLetter) chars += '$letterUpperCase';
    if (includeNumber) chars += '$number';
    if (includeSymbol) chars += '$symbol';
    if (chars.isEmpty) chars += '$letterLowerCase';
    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
