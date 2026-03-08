# Personal Task Manager App

## Project Overview

The **Personal Task Manager App** is a full-stack application that allows users to manage their daily tasks efficiently. The application is built using **Flutter** for the frontend and **Node.js with Express.js** for the backend, while **MongoDB** is used as the database.

The app provides a secure authentication system where users can register and log in. After logging in, users can create tasks, view all their tasks, mark tasks as completed, and delete tasks when they are no longer needed. Each task is associated with the authenticated user to ensure privacy and security.

The application also includes a **dashboard** that displays useful statistics such as total tasks, completed tasks, and pending tasks. This project demonstrates integration between a mobile frontend and RESTful backend APIs along with user authentication and database management.

---

# Tech Stack

### Frontend

* Flutter
* Dart
* Provider (State Management)
* SharedPreferences
* HTTP Package

### Backend

* Node.js
* Express.js
* MongoDB
* Mongoose
* JWT Authentication

---

# Features

* User Registration and Login
* JWT-based Authentication
* Create New Tasks
* View All Tasks
* Mark Tasks as Completed
* Delete Tasks
* Dashboard with Task Statistics
* Persistent Login using SharedPreferences
* Logout Functionality

---

# Project Structure

## Frontend (Flutter)

task_manager_app/

lib/

screens/

* login_screen.dart
* register_screen.dart
* dashboard_screen.dart
* task_screen.dart
* add_task_screen.dart

providers/

* task_provider.dart

services/

* api_service.dart
* auth_service.dart

models/

* task_model.dart

main.dart

---

## Backend (Node.js)

backend/

models/

* todo.model.js

controllers/

* todo.controller.js

routes/

* todo.routes.js

middleware/

* user.middleware.js

server.js

---

# Setup Instructions

## 1. Clone the Repository

git clone https://github.com/yourusername/task-manager-app.git

---

# Backend Setup

1. Navigate to backend folder

cd backend

2. Install dependencies

npm install

3. Create a `.env` file in the backend folder and add:

PORT=3000
MONGO_URI=your_mongodb_connection_string
JWT_SECRET=your_secret_key

4. Start the backend server

npm start

The backend will run on:

http://localhost:3000

---

# Frontend Setup

1. Navigate to Flutter project

cd task_manager_app

2. Install dependencies

flutter pub get

3. Run the application

flutter run

---

# API Endpoints

POST /api/user/register → Register new user
POST /api/user/login → Login user

POST /api/task → Create task
GET /api/task → Get all tasks
DELETE /api/task/:id → Delete task
GET /api/task/complete/:id → Mark task as completed

---

# Architectural Decisions

The application follows a **client-server architecture**.

### Frontend

The Flutter application uses **Provider for state management** to maintain and update application state efficiently. API calls are handled through a dedicated **ApiService**, and authentication operations are managed through **AuthService**. This separation improves code readability and maintainability.

### Backend

The backend follows the **MVC (Model-View-Controller) architecture**.

* **Models** define the MongoDB schema using Mongoose.
* **Controllers** contain the business logic for task operations.
* **Routes** define REST API endpoints.
* **Middleware** handles authentication using JWT tokens.

Each task is linked with a specific user ID to ensure users can only access their own tasks.

---

# Author

Rishabh Gupta
B.Tech Computer Science (2023–2027)
Deenbandhu Chhotu Ram University of Science and Technology

---
