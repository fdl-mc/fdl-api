# FreedomLand Server


## Description

An API server built with Dart for FreedomLand.

**Features:**

- Robust and efficient API routes for running an ecosystem.
- Simple deployment, based on pure Dart code and libraries.
- Easy configuration via environment variables.

## CLI Commands

| Command            | Description            |
| ------------------ | ---------------------- |
| `dart compile`     | Build/compile server.  |
| `dart run`         | Run server.            |
| `dart test`        | Run server tests.      |
| `dart format`      | Format project.        |

## Environment variables

| Variable                     | Description                                     |
| ---------------------------- | ----------------------------------------------- |
| `FDL_SERVER_MONGODB_URL`     | MongoDB auth URL.                               |
| `FDL_SERVER_PORT    `        | Server port.                                    |
| `FDL_SERVER_FBA_CREDENTIALS` | Firebase Admin credentials.                     |
| `FDL_SERVER_MAIN_IP`         | Main server IP, e.g. `play.fdl-mc.ru:25565`     |
| `FDL_SERVER_CREATIVE_IP`     | Creative server IP, e.g. `play.fdl-mc.ru:25565` |

## Resources

- [FreedomLand project board](https://github.com/fdl-mc/fdl-mc/discussions)

## Stack

- [Shelf](https://pub.dev/packages/shelf) (REST)
- [MongoDB](https://mongodb.com/) (Database)

## License

FDL Server is licensed under the [MIT License](https://github.com/fdl-mc/fdl-server/blob/master/LICENSE).
