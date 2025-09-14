plugins {
    id("com.android.application")
    // FlutterFire Configuration
    id("com.google.gms.google-services") // ✅ مهم جدًا
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // لازم يكون آخر واحد

    id("org.jetbrains.kotlin.android")

}

android {
    namespace = "com.example.evently_v2"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.3.13750724"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.example.evently_v2"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.0.0"))
    implementation("com.google.firebase:firebase-auth")
    implementation("androidx.credentials:credentials:1.3.0")
    implementation("androidx.credentials:credentials-play-services-auth:1.3.0")
    implementation("com.google.android.libraries.identity.googleid:googleid:1.1.1")
}
