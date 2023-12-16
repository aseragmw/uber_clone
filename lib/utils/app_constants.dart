
import 'package:uber_clone_app/utils/cache_manager.dart';

class AppConstants {
  
  static late String? driverId;

  static void initAppConstants() async {
   driverId = await CacheManager.getValue('driverId');
   
  }
}
