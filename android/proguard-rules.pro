# Keep Google's Tink library
-keep class com.google.crypto.tink.** { *; }
-dontwarn com.google.crypto.tink.**

# Keep error-prone annotations
-keep class com.google.errorprone.annotations.Immutable { *; }
-dontwarn com.google.errorprone.annotations.**

# Keep javax.annotation.concurrent classes
-keep class javax.annotation.concurrent.** { *; }
-dontwarn javax.annotation.concurrent.**
