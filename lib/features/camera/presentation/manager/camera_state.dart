abstract class CameraState {}

class CameraInitial extends CameraState {}

// حالات التعرف على لغة الإشارة
class TranslationLoading extends CameraState {}

class TranslationSuccess extends CameraState {
  final String newSign; // الحرف أو الرقم الجديد اللي اتعرف عليه
  final String fullText; // الجملة كاملة بعد الإضافة
  TranslationSuccess(this.newSign, this.fullText);
}

class TranslationError extends CameraState {
  final String message;
  TranslationError(this.message);
}

// حالات تحويل النص لصوت (TTS)
class TtsLoading extends CameraState {}

class TtsSuccess extends CameraState {
  final String audioUrl; // لينك الملف الصوتي اللي راجع من السيرفر
  TtsSuccess(this.audioUrl);
}

class TtsError extends CameraState {
  final String message;
  TtsError(this.message);
}