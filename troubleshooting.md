# Bài 5: Chẩn đoán và khắc phục Pipeline CI/CD

## Lỗi 1: Permission Denied

**Hiện tượng:** Gradle Wrapper không có quyền thực thi trên GitHub Actions Runner.

**Nguyên nhân:** File `gradlew` thiếu quyền thực thi trên hệ điều hành Linux.

**Cách khắc phục:** Thêm lệnh sau trước bước chạy test:

`chmod +x gradlew`

**Kết quả:** Bước kiểm thử Gradle chạy thành công.

## Lỗi 2: Authentication Failed

**Hiện tượng:** Docker Login báo lỗi `denied: denied` khi đăng nhập `ghcr.io`.

**Nguyên nhân:** Secret `REGISTRY_TOKEN` chưa được cấu hình hợp lệ hoặc thông tin xác thực không chính xác.

**Cách khắc phục:**
- Tạo GitHub Personal Access Token có quyền truy cập GitHub Packages.
- Thêm token vào repository secret tên `REGISTRY_TOKEN`.
- Sử dụng `${{ secrets.REGISTRY_TOKEN }}` trong bước `docker/login-action@v3`.

**Kết quả:** Docker Login thành công.

## Lỗi 3: Build Context Error

**Hiện tượng:** Docker không tìm thấy Dockerfile khi build Image nếu đường dẫn build context bị cấu hình sai.

**Nguyên nhân:** Workflow chỉ định sai thư mục làm việc hoặc đường dẫn đến Dockerfile.

**Cách khắc phục:** Sử dụng cấu hình:

```yaml
with:
  context: .
  file: ./Dockerfile
```

**Kết quả:** Docker tìm thấy Dockerfile, build và push Image thành công.

## Kết luận

Pipeline CI/CD đã chạy thành công trên GitHub Actions sau khi khắc phục lỗi xác thực Registry và kiểm tra các cấu hình quyền thực thi Gradle, Docker build context.

Toàn bộ các bước kiểm thử, đăng nhập Docker Registry và đóng gói Docker Image đều đạt trạng thái Success.
