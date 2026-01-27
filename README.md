# 🧠 Shared Thoughts

**Shared Thoughts** is a full-stack application built with **Flutter** (front-end) and **Supabase** (backend) that allows users to **share their thoughts** in a blog-like format.  

Each thought contains a **title, image, and content**, allowing users to express themselves on various topics. This app was built as a **portfolio project** to showcase full-stack capabilities and clean architecture implementation.

---

## 🚀 Live Demo

🔗 **Live Preview (GitHub Pages):**  
👉 [Live Preview Link](https://danial-03-dev.github.io/blog_app/)

---

## 🚀 Features

- 🔒 **User authentication** (Sign up / Login)
- ✏️ **Create, Read, Update, Delete (CRUD)** thoughts
- 🖼️ Attach **images** to thoughts
- 📃 Thoughts are displayed in a **blog-style format**
- 💻 Cross-platform support:
  - Web  
  - Windows  
  - Android
- 🏗️ Built with **Clean Architecture** for maintainable and scalable code
- 📦 Local caching with Hive for offline support

---

## 🏗️ Tech Stack

### Client
- **Flutter (Dart)**
- **Clean Architecture**
- **Flutter Bloc** for state management
- **Supabase Flutter** for backend interaction
- **GetIt** for dependency injection
- **Hive** for local storage
- **Image Picker** for attaching images
- **Internet Connection Checker Plus** for network status

### Backend
- **Supabase**
  - Authentication
  - PostgreSQL database
  - File storage for images

---

## 📦 Client Dependencies

```yaml
supabase_flutter: ^2.10.3
flutter_bloc: ^9.1.1
get_it: ^9.1.0
hive_flutter: ^1.1.0
image_picker: ^1.2.1
uuid: ^4.5.2
intl: ^0.20.2
internet_connection_checker_plus: ^2.9.1
fpdart: ^1.2.0
dotted_border: ^3.1.0
