import '../data/setting_repository.dart';

class SettingService {
  final SettingRepository settingRepository;

  SettingService({required this.settingRepository});

  Future<dynamic> depositCoin(String amount) async {
    dynamic data = await settingRepository.depositCoin(amount);
    return data;
  }
}
