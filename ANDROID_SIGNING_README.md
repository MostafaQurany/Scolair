# Scolair Android Production Signing README

This guide creates **one keystore file** with **three different production aliases**:

```text
scolair-release.jks
├── student
├── parent
└── teacher
```

This setup means the `student`, `parent`, and `teacher` apps each have their own production signing key, while you only manage one `.jks` file.

Official references:

- Flutter Android release/signing guide: <https://docs.flutter.dev/deployment/android>
- Java `keytool` documentation: <https://docs.oracle.com/javase/10/tools/keytool.htm>
- Google SHA-1 / client authentication guide: <https://developers.google.com/android/guides/client-auth>
- Google Play App Signing guide: <https://support.google.com/googleplay/android-developer/answer/9842756>

---

## 1. Project path

Your project root:

```powershell
E:\C\production projects\Scolair
```

Open **PowerShell** and run:

```powershell
cd "E:\C\production projects\Scolair"
```

Recommended structure:

```text
E:\C\production projects\Scolair
├── student
├── parent
├── teacher
├── _secure
│   └── keystores
│       └── scolair-release.jks
└── ANDROID_SIGNING_README.md
```

> Important: `_secure` must never be pushed to GitHub.

---

## 2. Create the secure keystore folder

From the project root:

```powershell
mkdir "E:\C\production projects\Scolair\_secure"
mkdir "E:\C\production projects\Scolair\_secure\keystores"
cd "E:\C\production projects\Scolair\_secure\keystores"
```

---

## 3. Create the keystore with 3 aliases

### 3.1 Create `student` alias

```powershell
keytool -genkeypair -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks" -alias student -keyalg RSA -keysize 2048 -validity 10000
```

This creates the keystore file and the first key alias.

Save these carefully:

```text
Keystore password: 123456
Student key password: 123456
```

### 3.2 Add `parent` alias

```powershell
keytool -genkeypair -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks" -alias parent -keyalg RSA -keysize 2048 -validity 10000
```

Use the same **keystore password** because it is the same `.jks` file.

Save this carefully:

```text
Parent key password: 123456
```

### 3.3 Add `teacher` alias

```powershell
keytool -genkeypair -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks" -alias teacher -keyalg RSA -keysize 2048 -validity 10000
```

Save this carefully:

```text
Teacher key password: 123456
```

---

## 4. Confirm that all aliases exist

Run:

```powershell
keytool -list -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks"
```

You should see:

```text
Alias name: student
Alias name: parent
Alias name: teacher
```

---

## 5. If `keytool` is not recognized

Try this command instead:

```powershell
& "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -list -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks"
```

You can also add Java/JDK to your Windows PATH later, but using the full `keytool.exe` path works immediately if Android Studio is installed.

---

## 6. Add `key.properties` to each Flutter app

Use forward slashes in `storeFile` to avoid Windows escaping problems.

Do **not** add quotation marks around the value.

---

### 6.1 `student/android/key.properties`

Create this file:

```text
E:\C\production projects\Scolair\student\android\key.properties
```

Content:

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_STUDENT_KEY_PASSWORD
keyAlias=student
storeFile=E:/C/production projects/Scolair/_secure/keystores/scolair-release.jks
```

---

### 6.2 `parent/android/key.properties`

Create this file:

```text
E:\C\production projects\Scolair\parent\android\key.properties
```

Content:

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_PARENT_KEY_PASSWORD
keyAlias=parent
storeFile=E:/C/production projects/Scolair/_secure/keystores/scolair-release.jks
```

---

### 6.3 `teacher/android/key.properties`

Create this file:

```text
E:\C\production projects\Scolair\teacher\android\key.properties
```

Content:

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_TEACHER_KEY_PASSWORD
keyAlias=teacher
storeFile=E:/C/production projects/Scolair/_secure/keystores/scolair-release.jks
```

---

## 7. Configure `android/app/build.gradle`

Do this inside each app:

```text
student/android/app/build.gradle
parent/android/app/build.gradle
teacher/android/app/build.gradle
```

Near the top of the file, before `android { ... }`, add:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

Inside `android { ... }`, add or update the release signing configuration:

```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

If the file already has `buildTypes { release { ... } }`, do not duplicate it. Just replace this line:

```gradle
signingConfig signingConfigs.debug
```

with:

```gradle
signingConfig signingConfigs.release
```

---
/

## 8. Update `.gitignore`

Add this to the root `.gitignore`:

```gitignore
# Android signing secrets
_secure/
*.jks
*.keystore
**/key.properties
```

Never commit these files:

```text
_secure/keystores/scolair-release.jks
student/android/key.properties
parent/android/key.properties
teacher/android/key.properties
```

---

## 9. Get SHA-1 and SHA-256 for Firebase

### 9.1 Student SHA fingerprints

```powershell
keytool -list -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks" -alias student
```

Copy the `SHA1` and `SHA256` values into the Firebase Android app for `student`.

### 9.2 Parent SHA fingerprints

```powershell
keytool -list -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks" -alias parent
```

Copy the `SHA1` and `SHA256` values into the Firebase Android app for `parent`.

### 9.3 Teacher SHA fingerprints

```powershell
keytool -list -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks" -alias teacher
```

Copy the `SHA1` and `SHA256` values into the Firebase Android app for `teacher`.

---

## 10. Firebase location

For each Firebase Android app:

```text
Firebase Console
→ Project settings
→ General
→ Your apps
→ Select Android app
→ Add fingerprint
→ Add SHA-1
→ Add SHA-256
```

Do this for all Android package IDs, for example:

```text
com.scolair.student
com.scolair.parent
com.scolair.teacher
```

Use the real package names from each app.

---

## 11. Build release app bundles

### 11.1 Build student

```powershell
cd "E:\C\production projects\Scolair\student"
flutter clean
flutter pub get
flutter build appbundle --release
```

Output:

```text
student\build\app\outputs\bundle\release\app-release.aab
```

### 11.2 Build parent

```powershell
cd "E:\C\production projects\Scolair\parent"
flutter clean
flutter pub get
flutter build appbundle --release
```

Output:

```text
parent\build\app\outputs\bundle\release\app-release.aab
```

### 11.3 Build teacher

```powershell
cd "E:\C\production projects\Scolair\teacher"
flutter clean
flutter pub get
flutter build appbundle --release
```

Output:

```text
teacher\build\app\outputs\bundle\release\app-release.aab
```

---

## 12. Google Play App Signing important note

When you upload an app to Google Play, Google Play App Signing may use a different **app signing certificate** from your local upload keystore.

For Firebase, Google Sign-In, Dynamic Links, and other Google services, add the SHA-1/SHA-256 from:

```text
Google Play Console
→ Select app
→ Setup / Test and release area
→ App signing
→ App signing key certificate
→ Copy SHA-1 and SHA-256
```

Add those fingerprints to the matching Firebase Android app too.

Usually, for production, Firebase should include:

```text
1. Local release/upload key SHA-1 and SHA-256
2. Google Play app signing key SHA-1 and SHA-256
3. Debug SHA-1 and SHA-256 for development testing
```

---

## 13. Backup checklist

Keep backups of:

```text
scolair-release.jks
Keystore password
Student key password
Parent key password
Teacher key password
```

Recommended backup locations:

```text
1. Password manager
2. Encrypted external drive
3. Secure cloud vault
```

Do not store passwords in plain text in GitHub, Slack, WhatsApp, or project screenshots.

---

## 14. Quick command summary

```powershell
cd "E:\C\production projects\Scolair"
mkdir "E:\C\production projects\Scolair\_secure"
mkdir "E:\C\production projects\Scolair\_secure\keystores"

keytool -genkeypair -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks" -alias student -keyalg RSA -keysize 2048 -validity 10000
keytool -genkeypair -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks" -alias parent -keyalg RSA -keysize 2048 -validity 10000
keytool -genkeypair -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks" -alias teacher -keyalg RSA -keysize 2048 -validity 10000

keytool -list -v -keystore "E:\C\production projects\Scolair\_secure\keystores\scolair-release.jks"
```
