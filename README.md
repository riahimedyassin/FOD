**Install**

Clone the repository.

```bash
git clone <repos_link>
```

Building an executable

```bash
dart compile exe bin/main.dart -o <executable_name>
```

---

Running directly

```
dart run bin/main.dart
```

**Config**

Specify the folder name and the file extensions that should be present within that folder in the **config.yaml**.

Example :

```yml
documents:
  - txt
  - pdf
  - rar
images:
  - png
  - jpg
  - jpeg
```

**NOTE** : The config file is present in the project folder structure. You need to pre-specify the config before building / executing the CLI.
