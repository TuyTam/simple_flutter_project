# Lam quen voi ung dung web dong don gian
## Cac buoc thuc hien
### Buoc 3: Tao ung dung fontend bang Flutter framework
1. Quay lai thu muc du an chinh
    ```bash
    cd ..
    ```
2. Chuyen den thu muc frontend
    ```bash
    cd frontend
    ```
3. Khoi tao du an Flutter moi trong thu muc frontend
    ```bash
    flutter create -e .
    ```
    **Luu y:** Lenh tren se tao mot du an Flutter moi trong thu muc frontend voi mau la `Empty Application` hay tham so `-e` va tham so dau cham `.` cho biet se khoi tao trong thu muc hien tai la thu muc `frontend`.
4. Them thu vien `http` vao du an frontend
    ```bash
    flutter pub add http
    ```
### Buoc 4: Thiet lap debug cho ca backend va frontend
- Open `frontend/lib/main.dart` first
- Select `Run and Debug` on Side Bar and select `create a launch.json file` to create a debug config file.
- Process backend and frontend debug
**Luu y:** We set the default port for server backend is 8080 and frontend is 8081 when debugging. We can change these ports.

### Step 5: Publish source code to GitHub and manage source code
- Select `Source Control` at Side Bar and select `Publish to GitHub`.
- Manage source code by commit, push (Sync Changes...), pull, ... from `Source Control` window.

### Step 6: Develop backend and test
2. Debug backend va kiem thu voi Postman
3. Them Middleware xu ly CORS cho backend
- **CORS (Cross-Origin Resource Sharing)** la mot co che bao mat duoc cac trinh duyet web su dung de ngan chan cac trang web gui yeu cau den mot domain khac voi domain cua trang hien tai. Dieu nay nham bao ve nguoi dung khoi cac cuoc tan cong CSRF (Cros-Site Request Forgery) va cac moi de doa bao mat khac.
- **Vi sao can them CORS middleware?** Khi frontend (Flutter web) gui yeu cau HTTP den backend tren mot domain khac, trinh duyet web se chan yeu cau do vi pham chinh sach cung nguon goc (Same-Origin Policy). Cac yeu cau tu Flutter Web (chay tren localhost: 8081) den server backend (chay tren localhost: 8080) se bi chan neu server khong xu ly dung cac header CORS. Trinh duyet se gui mot yeu cau OPTIONS (Preflight Request) de kiem tra xem server co cho phep khong. Neu server khong phan hoi dung, yeu cau chinh se khong duoc gui.
- **Giai phap:** Them Middleware xu ly CORS vao server backend de xu ly cac yeu cau OPTIONS bang cach tra ve cac header CORS can thiet. THem cac header CORS vao tat car cac phan hoi tu server de trinh duyet cho phep giao tiep giua frontend va backend.
- Cap nhat ma nguon ham main.
```dart

```


### Step 7: Develop frontend va tich hop he thong