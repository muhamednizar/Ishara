/// نمط Use Case كما في bookly-app — بدون ربط بـ UI.
///
/// [Type] نوع الناتج، [Params] نوع المدخلات.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// للـ use cases التي لا تحتاج باراميترات.
class NoParams {
  const NoParams();
}
