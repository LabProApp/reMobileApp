import 'package:property_mvp_fe/core/network/error_handling_api.dart';
import 'package:property_mvp_fe/features/bank/data/models/bank_model.dart';

abstract class BankRepository {
Future<OnComplete<List<FetchBanks>>> fetchBanks();
}
