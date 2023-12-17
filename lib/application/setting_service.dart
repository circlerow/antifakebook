import '../data/setting_repository.dart';
import '../domain/setting.dart';

class SettingService {
  final SettingRepository settingRepository;

  SettingService({required this.settingRepository});

  Future<dynamic> depositCoin(String amount) async {
    dynamic data = await settingRepository.depositCoin(amount);
    return data;
  }

  Future<dynamic> getPushSetting() async {
    dynamic data = await settingRepository.getPushSetting();
    return data["data"];
  }

  Future<dynamic> setPushSetting(PushSetting pushSetting) async {
    dynamic data = await settingRepository.setPushSetting(pushSetting);
    return data;
  }
}
