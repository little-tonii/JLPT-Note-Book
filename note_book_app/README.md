1. Phần "core" thường chứa:

- Các lớp trừu tượng và interface cốt lõi
- Các hằng số và cấu hình toàn cục
- Các tiện ích và helper functions sử dụng xuyên suốt ứng dụng
- Các service chung (như logging, analytics, error handling)
- Các extension methods
- Các middleware
- Các interceptor cho network requests
- Các custom exceptions

2. Phần "common" thường chứa:

- Các widget dùng chung
- Các styles và theme chung
- Các assets (hình ảnh, fonts, etc.) dùng chung
- Các translations và localization resources
- Các constants dùng chung (như string constants, color constants)
- Các utility functions không thuộc về logic nghiệp vụ cốt lõi
- Các custom animations dùng chung
- Các mixins dùng chung

"core" tập trung vào các thành phần cốt lõi và trừu tượng của ứng dụng, trong khi "common" chứa các thành phần dùng chung nhưng có thể cụ thể hơn và liên quan đến UI/UX.