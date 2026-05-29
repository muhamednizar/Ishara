import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/utils/local_storage_service.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final LocalStorageService localStorageService;
  bool _isDarkMode = false;

  ThemeCubit(this.localStorageService) : super(ThemeInitial());

  bool get isDarkMode => _isDarkMode;

  Future<void> loadThemePreference() async {
    try {
      _isDarkMode = await localStorageService.getThemeMode() ?? false;
      emit(ThemeChanged(_isDarkMode));
    } catch (e) {
      _isDarkMode = false;
      emit(ThemeChanged(false));
    }
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await localStorageService.saveThemeMode(_isDarkMode);
    emit(ThemeChanged(_isDarkMode));
  }
}
