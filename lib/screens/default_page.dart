import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant/ConstantStyling.dart';
import '../generated/l10n.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    double progress = 0.9;
    double countdown = 2.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).overview),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 10,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: AppTextStyles.bold40,
                    ),
                    Text(
                      S.of(context).todayProgress,
                      style: AppTextStyles.regular20,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20), // Add some space between the sections
            Text(
                S.of(context).nextReminder(countdown),
                style: AppTextStyles.grey16Regular
            ),
          ],
        ),
      ),
    );
  }
}
