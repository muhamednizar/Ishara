import 'package:flutter_bloc/flutter_bloc.dart';
import 'camera_state.dart';
import 'package:ishara/features/camera/data/repos/translation_repo_impl.dart';

class CameraCubit extends Cubit<CameraState> {
  final TranslationRepoImpl translationRepo;
  
  String fullText = ""; 
  String lastDetectedLetter = ""; 
  bool _isProcessing = false; 

  CameraCubit(this.translationRepo) : super(CameraInitial());

  Future<void> processFrame({required String imagePath, required bool isLettersMode}) async {
    if (_isProcessing) return; 
    _isProcessing = true;

    if (isLettersMode) {
      final result = await translationRepo.translateLetter(imagePath);
      result.fold(
        ifLeft: (error) {
          _isProcessing = false;
          emit(TranslationError(error));
        },
        ifRight: (letter) async {
          _isProcessing = false;
          
          // 🎯 الفلتر الذكي للحروف
          if (letter != null && letter.trim().isNotEmpty && letter != 'null') {
            if (letter != lastDetectedLetter) {
              fullText += letter;
              lastDetectedLetter = letter; 
            }
          } else {
            lastDetectedLetter = ""; 
          }
          
          emit(CameraInitial()); 
          await Future.delayed(const Duration(milliseconds: 10));
          emit(TranslationSuccess(letter ?? '', fullText));
        },
      );
    } else {
      final result = await translationRepo.translateNumber(imagePath);
      result.fold(
        ifLeft: (error) {
          _isProcessing = false;
          emit(TranslationError(error));
        },
        ifRight: (number) async {
          _isProcessing = false;
          
          // 🎯 الفلتر الذكي للأرقام
          if (number != null) {
            final numStr = number.toString();
            if (numStr != lastDetectedLetter) {
              fullText += numStr;
              lastDetectedLetter = numStr;
            }
          } else {
            // تصفير الفلتر لو مفيش إيد
            lastDetectedLetter = ""; 
          }

          emit(CameraInitial());
          await Future.delayed(const Duration(milliseconds: 10));
          emit(TranslationSuccess(number?.toString() ?? "", fullText));
        },
      );
    }
  }

  void addSpace() async {
    fullText += " ";
    lastDetectedLetter = " "; 
    emit(CameraInitial());
    await Future.delayed(const Duration(milliseconds: 10));
    emit(TranslationSuccess(" ", fullText));
  }

  void removeLastCharacter() async {
    if (fullText.isNotEmpty) {
      fullText = fullText.substring(0, fullText.length - 1);
      lastDetectedLetter = ""; 
      emit(CameraInitial());
      await Future.delayed(const Duration(milliseconds: 10));
      emit(TranslationSuccess("", fullText));
    }
  }

  void clearText() {
    fullText = "";
    lastDetectedLetter = "";
    emit(CameraInitial());
  }


}