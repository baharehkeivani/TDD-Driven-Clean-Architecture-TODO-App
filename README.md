## 🙋‍♂️ Why This Project?

This is **not a reusable package**, but a **tutorial repository** to help Flutter developers:
- 📂 Clean Architecture structure
- ▶ State Management with Cubits
- 🧪 Unit tests for domain and data layers and cubits
- 🔄 Continuous Integration via GitHub Actions

---

## 🏗️ Architecture Overview

This project adopts the **Clean Architecture** approach.
Each layer is **independent**, testable, and follows the **separation of concerns** principle.

---

## 🧪 Testing

Unit tests are included and cover:

- Use cases
- Repository contracts
- Entities and value objects

Run tests with:

```bash
flutter test
````

---

## ⚙️ Continuous Integration

This project includes a CI pipeline using **GitHub Actions**:

* Runs unit tests on every push and pull request
* Ensures code quality and reliability

You can find the workflow in `.github/workflows/flutter_ci.yml`.

---

## 📬 Contact

Feel free to reach out with questions or feedback via [GitHub Issues](https://github.com/baharehkeivani/TDD-Driven-Clean-Architecture-TODO-App/issues).

Happy coding! 🚀


