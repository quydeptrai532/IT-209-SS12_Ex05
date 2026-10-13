# Spring Boot Gradle - CI Matrix JDK 17 & 21

## Noi dung
- Java Spring Boot REST API: `GET /hello` -> `Hello CI Matrix!`
- JUnit 5 test: `HelloControllerTest`
- GitHub Actions workflow: `.github/workflows/ci-matrix.yml`
- Matrix: Java 17 va Java 21, cache Gradle

## Chay test tren Windows
```powershell
.\gradlew.bat test
```

## Chay test tren Linux/macOS
```bash
chmod +x gradlew
./gradlew test
```

## Push len GitHub
```bash
git init
git branch -M main
git add .
git commit -m "Add Spring Boot CI Matrix"
git remote add origin https://github.com/USERNAME/REPOSITORY.git
git push -u origin main
```

Vao GitHub -> Actions -> CI Matrix Test, kiem tra 2 job Java 17 va 21 xanh, chup anh nop bai.

**Luu y:** Do moi truong tao ZIP khong tai duoc Gradle wrapper JAR chinh thuc, `gradlew` va `gradlew.bat` la launcher tu dong tai Gradle 8.14.3 lan dau (khong phai Gradle Wrapper chinh thuc). May chay can internet; Windows can PowerShell, Linux can curl/unzip. GitHub Actions Ubuntu ho tro cac cong cu nay. De thay bang wrapper chinh thuc, khi da cai Gradle co the chay `gradle wrapper --gradle-version 8.14.3` va commit `gradle/wrapper/gradle-wrapper.jar` cung cac script moi.

**Chua xac minh test tren GitHub Actions:** Can push len GitHub de kiem tra ket qua thuc te.
