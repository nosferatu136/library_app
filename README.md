# 📚 Library API -- Rails 8

A simple **Rails 8 JSON API** providing:

-   **User authentication** using Devise\
-   **Authorization** using CanCanCan\
-   **Two user roles:**
    -   *Librarians* (admins) --- manage books\
    -   *Members* --- borrow & return books\
-   **Books CRUD**\
-   **Borrow / Return endpoints**\
-   **Swagger (OpenAPI 3) documentation**\
-   **RSpec test suite**\
-   **Seeds with sample users & books**

## 📦 Requirements

  Component    Version
  ------------ ---------
  Ruby         3.2+
  Rails        8.x
  PostgreSQL   13+
  Bundler      Latest

## 🚀 Installation

``` bash
git clone <your-repo-url>
cd library_api
bundle install
rails db:create
rails db:migrate
rails db:seed
```

Start the API:

``` bash
rails server
```

## 🔐 Authentication Model

  Role        Description    Permissions
  ----------- -------------- ---------------------------------------------
  Librarian   Admin user     Manage all books, also mark them as returned
  Member      Regular user   Borrow books

## 🔒 Authorization

Librarians → full CRUD on Books\
Members → read-only, plus borrow/return actions

## 📘 API Overview

Base URL:

    http://localhost:3000

## 📄 Swagger Documentation

    /api-docs

# 📚 Endpoints

## Authentication

### GETPOST /sign_up --- Signup

### POST /login --- Login

## Books

### GET /books
### GET /books/search

### POST /books (Librarian only)

### GET /books/:id

### PATCH /books/:id (Librarian only)

### DELETE /books/:id (Librarian only)

## Borrowing

### POST /borrowings --- borrow (Member only)

### PATCH /borrowings/:id --- return (Librarian only)

## Dashboards

### GET /librarian/dashboard
### GET /member/dashboard

## 🌱 Seed Data

Creates: - librarian@example.com - member@example.com - 5 sample books

## 🧪 Tests

Run tests:

``` bash
bundle exec rspec
```

## 🧰 Project Structure

    app/
      controllers/
      models/
    config/
    spec/
    swagger/

## 📄 License

MIT
