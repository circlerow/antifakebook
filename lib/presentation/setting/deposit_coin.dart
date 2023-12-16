// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../application/setting_service.dart';
import '../../data/setting_repository.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  _DepositScreenState createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _amountController = TextEditingController();
  final SettingService settingService =
      SettingService(settingRepository: SettingRepositoryImpl());
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nạp Tiền'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/icon.webp',
                  width: 250.0,
                  height: 250.0,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Nạp thêm tiền để trải nghiệm dịch vụ tốt hơn',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 16.0, width: double.infinity),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Nhập số tiền',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Icon(Icons.monetization_on),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    String amountText = _amountController.text;
                    if (amountText.isNotEmpty) {
                      String amount = double.parse(amountText).toString();
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        Map<String, dynamic> result =
                            await settingService.depositCoin(amount);
                        if (result['code'] == '1000') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Thành công'),
                                content: const Text('Nạp tiền thành công!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _amountController.clear();
                                    },
                                    child: const Text('Đóng'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Lỗi'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Đóng'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  },
                  child: const Text('Nạp Tiền'),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
