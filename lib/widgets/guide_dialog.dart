import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../Base/bluetooth_provider.dart';

class GuideDialog {
  static void showFirstTimeConnectionGuide(BuildContext context, BluetoothProvider provider) {
    final deviceId = provider.connectedDevice?.remoteId.toString() ?? '';
    final deviceName = provider.connectedDevice?.name ?? deviceId;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF2E7CFF)),
            SizedBox(width: 10),
            Text(
              S.of(context).deviceGuide,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).welcomeToDevice(deviceName),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(S.of(context).firstTimeConnectionInstructions),
            SizedBox(height: 12),
            _buildStepItem(context, 1, S.of(context).waitForFirstDataPacket),
            _buildStepItem(context, 2, S.of(context).calibrateAfterDataReceived),
            _buildStepItem(context, 3, S.of(context).weightDataMoreAccurate),
            SizedBox(height: 16),
            Text(
              S.of(context).calibrationImportanceNote,
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[700]),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
                  provider.resetCalibrationGuide();
                  Navigator.pop(context);
                },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E7CFF),
            ),
            child: Text(S.of(context).confirm, style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  static Widget _buildStepItem(BuildContext context, int step, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(0xFF2E7CFF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}