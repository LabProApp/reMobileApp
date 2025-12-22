import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_mvp_fe/features/bank/domain/repo/bank_repository.dart';
import 'package:property_mvp_fe/features/bank/presentation/controller/bank_state.dart';

class BankCubit extends Cubit<BankState> {
  final BankRepository bankRepository;

  BankCubit({required this.bankRepository}) : super(BankInitialState());

  Future<void> loadBanks() async {
    try {
      emit(BankLoadingState());
      final banks = await bankRepository.fetchBanks();
      emit(BankLoadedState(banks: banks.data!));
    } catch (e) {
      emit(BankErrorState(message: e.toString()));
    }
   

    
  }
}