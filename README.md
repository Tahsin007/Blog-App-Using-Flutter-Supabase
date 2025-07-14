# Blog App Using Flutter & Supabase

This is a feature-rich blog application built with Flutter and powered by Supabase. It provides a seamless and intuitive experience for both readers and writers.

## Features

*   **Authentication:** Secure user authentication (signup/login) using Supabase Auth.
*   **Create & Publish:** A powerful editor to write, format, and publish blog posts.
*   **Image Uploads:** Easily upload and embed images in your blog posts.
*   **Read Time Calculation:** Automatically calculates and displays the estimated reading time for each post.
*   **Offline Support:** (If implemented) Gracefully handles offline scenarios, allowing users to read cached articles and sync when back online.
*   **Themeing:** A beautiful and consistent UI with a custom color palette and text styles.
*   **State Management:** Efficient and predictable state management using Flutter Bloc.
*   **Dependency Injection:** A clean and maintainable architecture using `get_it` for service location.

## Folder Structure

The project follows a clean and scalable folder structure, separating concerns into distinct layers:

```
lib/
├── core/
│   ├── common/
│   │   ├── cubits/
│   │   ├── entities/
│   │   └── widgets/
│   ├── error/
│   ├── secrets/
│   ├── theme/
│   ├── usecase/
│   └── utils/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── data_source/
│   │   │   ├── model/
│   │   │   └── repository_impl/
│   │   ├── domain/
│   │   │   ├── repository/
│   │   │   └── use_case/
│   │   └── presentation/
│   │       ├── bloc/
│   │       └── pages/
│   └── blog/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── init_dependencies.dart
└── main.dart
```

## Architecture Overview

The application is built using a clean architecture, separating the code into three main layers:

*   **Data Layer:** Responsible for all data operations, including fetching data from the Supabase backend and handling local storage. It contains data sources, models, and repository implementations.
*   **Domain Layer:** Contains the core business logic of the application. It defines the entities, use cases, and repository interfaces. This layer is independent of the UI and data layers.
*   **Presentation Layer:** This is the UI layer of the application. It contains the widgets, pages, and Blocs that manage the state of the UI.

## Dependencies & Packages

This project utilizes a modern and robust set of packages to ensure a high-quality development experience:

| Package                        | Description                               |
| ------------------------------ | ----------------------------------------- |
| `flutter`                      | The core Flutter framework.               |
| `cupertino_icons`              | iOS-style icons.                          |
| `google_fonts`                 | Customizable fonts from Google Fonts.     |
| `get_storage`                  | A fast and extra-light key-value storage. |
| `get`                          | A powerful and lightweight state manager. |
| `share_plus`                   | For sharing content from the app.         |
| `fpdart`                       | Functional programming in Dart.           |
| `supabase_flutter`             | The official Flutter SDK for Supabase.    |
| `flutter_bloc`                 | A predictable state management library.   |
| `get_it`                       | A simple service locator for Dart.        |
| `dotted_border`                | A package for creating dotted borders.    |
| `image_picker`                 | A plugin for selecting images.            |
| `uuid`                         | For generating unique identifiers.        |
| `storybook_flutter`            | For UI component development and testing. |
| `internet_connection_checker_plus` | For checking internet connectivity.       |

## Developer Instructions

To clone and run this project locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/Blog-App-Using-Flutter-Supabase.git
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Set up Supabase:**
    *   Create a new project on [Supabase](https://supabase.io/).
    *   In your Supabase project, go to the "SQL" tab and run the SQL queries from the `schema.sql` file (if provided) to create the necessary tables.
    *   Go to "Settings" -> "API" and get your "Project URL" and "anon key".
4.  **Configure Supabase in the app:**
    *   Create a file named `app_secrets.dart` in `lib/core/secrets/`.
    *   Add the following code to the file, replacing the placeholders with your actual Supabase credentials:
        ```dart
        class AppSecrets {
          static const String supabaseUrl = 'YOUR_SUPABASE_URL';
          static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
        }
        ```
5.  **Run the app:**
    ```bash
    flutter run
    ```

Now you should have the Blog App running on your local machine.