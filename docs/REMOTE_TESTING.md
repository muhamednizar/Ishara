# تجربة التطبيق مع زملاء (بدون نفس الـ Wi‑Fi)

التطبيق كان يتصل بـ `http://192.168.x.x` — ده يشتغل **بس** على نفس شبكة الواي فاي.
للوصول من أي مكان: اعرض السيرفر المحلي على الإنترنت بـ **ngrok** (مجاني).

---

## 1) شغّل الـ Backend على جهازك

```bash
# Django — لازم يقبل اتصالات من برة الجهاز
python manage.py runserver 0.0.0.0:8000
```

في `settings.py` تأكد من:

```python
ALLOWED_HOSTS = ['*']  # للتجربة فقط — لا تستخدم * في الإنتاج
```

لو عندك `CORS`، اسمح بكل المصادر مؤقتاً للتجربة.

---

## 2) افتح نفق ngrok

1. حمّل ngrok من [https://ngrok.com](https://ngrok.com) وسجّل حساب مجاني.
2. في Terminal:

```bash
ngrok http 8000
```

3. انسخ الرابط اللي يظهر، مثل:
   `https://a1b2c3d4.ngrok-free.app`

---

## 3) شغّل أو ابنِ التطبيق بالرابط الجديد

**على جهازك (تطوير):**

```bash
flutter run --dart-define=API_BASE_URL=https://a1b2c3d4.ngrok-free.app/api/
```

**APK لزملائك:**

```bash
flutter build apk --dart-define=API_BASE_URL=https://a1b2c3d4.ngrok-free.app/api/
```

الملف: `build/app/outputs/flutter-apk/app-release.apk` — ابعته لأي حد يثبّته.

> **مهم:** رابط ngrok المجاني **يتغيّر** كل ما تقفل ngrok وتفتحه تاني. ساعتها لازم تبني APK جديد بالرابط الجديد، أو تستخدم [دومين ثابت](https://ngrok.com/docs/guides/how-to-set-up-a-custom-domain) (مدفوع).

---

## 4) ما يحتاجش نفس الـ Wi‑Fi

| الطريقة | من يقدر يتصل؟ |
|---------|----------------|
| `192.168.x.x` | نفس الواي فاي فقط |
| ngrok `https://....ngrok-free.app` | أي شبكة (واي فاي / 4G) |

---

## 5) استكشاف الأخطاء

| المشكلة | الحل |
|---------|------|
| Connection refused | تأكد `runserver 0.0.0.0:8000` و ngrok شغال |
| 400 Bad Request / DisallowedHost | أضف `*` أو دومين ngrok في `ALLOWED_HOSTS` |
| 403 من ngrok | التطبيق يبعت تلقائياً `ngrok-skip-browser-warning` |
| APK قديم | ابنِ APK جديد بعد تغيير رابط ngrok |

---

## بدائل ngrok

- [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/) — دومين ثابت أسهل
- نشر الـ API على Render / Railway — للمشاريع الجادة (رابط ثابت دائم)
