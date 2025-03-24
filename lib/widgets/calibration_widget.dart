import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Base/bluetooth_provider.dart';
import '../services/calibration_service.dart';
import '../generated/l10n.dart';

class CalibrationWidget extends StatefulWidget {
  const CalibrationWidget({Key? key}) : super(key: key);

  @override
  _CalibrationWidgetState createState() => _CalibrationWidgetState();
}

class _CalibrationWidgetState extends State<CalibrationWidget> {
  final CalibrationService _calibrationService = CalibrationService();
  final TextEditingController _calibrationValueController = TextEditingController();
  bool _isCalibrationHistoryVisible = false;
  Map<String, dynamic> _calibrationHistory = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCalibrationHistory();
  }

  @override
  void dispose() {
    _calibrationValueController.dispose();
    super.dispose();
  }

  Future<void> _loadCalibrationHistory() async {
    setState(() {
      _isLoading = true;
    });

    final history = await _calibrationService.getAllCalibrations();

    setState(() {
      _calibrationHistory = history;
      _isLoading = false;
    });
  }

  void _showCalibrationDialog(BuildContext context, BluetoothProvider provider) {
    final deviceId = provider.connectedDevice?.remoteId.toString() ?? '';
    final hasReceivedData = provider.parsedDataPackets.isNotEmpty;
    final latestWeight = hasReceivedData ? provider.parsedDataPackets.last['Weight'] : 0.0;

    _calibrationValueController.text = latestWeight.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).calibration),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).enterCalibrationValue),
            SizedBox(height: 10),
            TextField(
              controller: _calibrationValueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: S.of(context).calibrationValueHint,
                suffixText: S.of(context).unit,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).no),
          ),
          ElevatedButton(
            onPressed: hasReceivedData
                ? () async {
                    if (_calibrationValueController.text.isNotEmpty) {
                      final calibrationValue =
                          double.tryParse(_calibrationValueController.text) ?? 0.0;
                      await _calibrationService.saveCalibration(
                          deviceId, calibrationValue,
                          deviceName: provider.connectedDevice?.name);

                      _calibrationValueController.clear();
                      Navigator.pop(context);
                      _loadCalibrationHistory();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).calibrationSaved),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E7CFF),
            ),
            child: Text(S.of(context).yes),
          ),
        ],
      ),
    );
  }

  void _showCalibrationHistoryDialog(BuildContext context, BluetoothProvider provider) {
    final currentDeviceId = provider.connectedDevice?.remoteId.toString() ?? '';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.history, color: Color(0xFF2E7CFF)),
            SizedBox(width: 10),
            Text(
              S.of(context).calibrationHistory,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
          child: _isLoading
              ? Center(child: CircularProgressIndicator(color: Color(0xFF2E7CFF)))
              : _calibrationHistory.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.info_outline, size: 48, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            S.of(context).noCalibrationHistory,
                            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: _calibrationHistory.length,
                      separatorBuilder: (context, index) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final deviceId = _calibrationHistory.keys.elementAt(index);
                        final calibrationData = _calibrationHistory[deviceId];
                        final timestamp = calibrationData['timestamp'];
                        final value = calibrationData['value'];
                        final deviceName = calibrationData['deviceName'];
                        final displayName = deviceName ?? deviceId;
                        final isCurrentDevice = deviceId == currentDeviceId;

                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          color: null,
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Row(
                              children: [
                                // Icon(Icons.bluetooth, size: 16, color: isCurrentDevice ? Color(0xFF2E7CFF) : Colors.grey),
                                // SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    displayName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isCurrentDevice ? Color(0xFF2E7CFF) : Colors.black87,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.scale, size: 14, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          '${S.of(context).value}: $value ${S.of(context).unit}',
                                          style: TextStyle(fontSize: 12, color: Colors.black87),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 14, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          '${S.of(context).date}: ${_calibrationService.formatCalibrationTime(timestamp)}',
                                          style: TextStyle(fontSize: 12, color: Colors.black87),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            trailing: isCurrentDevice
                                ? Container(
                                    margin: EdgeInsets.only(right: 0),
                                    child: IconButton(
                                      icon: Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                      tooltip: S.of(context).delete,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            title: Text(S.of(context).confirmDelete),
                                            content: Text(S.of(context).confirmDeleteCalibration),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: Text(S.of(context).cancel),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  await _calibrationService.deleteCalibration(deviceId);
                                                  _loadCalibrationHistory();
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text(S.of(context).calibrationDeleted),
                                                        backgroundColor: Colors.red,
                                                        behavior: SnackBarBehavior.floating,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        action: SnackBarAction(
                                                          label: S.of(context).close,
                                                          textColor: Colors.white,
                                                        onPressed: () {},
                                                      ),
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  foregroundColor: Colors.white,
                                                ),
                                                child: Text(S.of(context).delete),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : null,
                            enabled: isCurrentDevice,
                          ),
                        );
                      },
                    ),
        ),
        actions: [
          ElevatedButton.icon(
            icon: Icon(Icons.close),
            label: Text(S.of(context).close),
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E7CFF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothProvider>(builder: (context, provider, child) {
      final hasReceivedData = provider.parsedDataPackets.isNotEmpty;
      final deviceId = provider.connectedDevice?.remoteId.toString() ?? '';

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: 'calibration',
            onPressed: hasReceivedData
                ? () => _showCalibrationDialog(context, provider)
                : null,
            backgroundColor: hasReceivedData ? Color(0xFF2E7CFF) : Colors.grey,
            child: Icon(Icons.scale, color: Colors.white),
            tooltip: S.of(context).calibration,
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            heroTag: 'calibrationHistory',
            onPressed: () => _showCalibrationHistoryDialog(context, provider),
            backgroundColor: Color(0xFF2E7CFF),
            child: Icon(Icons.history, color: Colors.white),
            tooltip: S.of(context).calibrationHistory,
          ),
        ],
      );
    });
  }
}