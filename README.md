# SQLPad Helm Chart

Helm Chart to install SQLPad in a kubernetes cluster.

### Prerequisites

- Kubernetes 1.19+
- Helm 3+

### Chart Installation

To install the chart with the release name `sqlpad`:

```shell
$ git clone https://github.com/wastrachan/sqlpad-chart.git
$ helm install sqlpad sqlpad-chart
```

### Configuration

Configuration of SQLPad is handled via the environment. This chart contains base configuration
(defined in the `environmentBase` parameter), but you will want to override the configuration with your installation.

Use the `environmentOverride` parameter to provide additional environment variables, which will override those in
`environmentBase`.

For a full list of configuration options, [review the SQLPad documentation](https://getsqlpad.com/#/configuration).

#### Minimum Configuration Example

:warning: **At a minimum, you should set the default admin password** :warning:

```yaml
environmentOverride:
  SQLPAD_ADMIN: "admin"
  SQLPAD_ADMIN_PASSWORD: "sqlpad"
  SQLPAD_PASSPHRASE: "2719e693fcd80e8c220ebc5f721b665e"

mariadb:
  auth:
    password: ae880f3c4541a4aad456eeec2dc3f15e
    rootPassword: 4d3336a14b1031c9d1eefa3d7e4203d6
```

### Parameters

#### SQLPad

| Parameter                    | Description                                                                                    | Value           |
| ---------------------------- | ---------------------------------------------------------------------------------------------- | --------------- |
| `replicaCount`               | Number of SQLPad server instances                                                              | `1`             |
| `image.repository`           | SQLPad image repository                                                                        | `sqlpad/sqlpad` |
| `image.pullPolicy`           | SQLPad image pull policy                                                                       | `IfNotPresent`  |
| `image.tag`                  | SQLPad image tag (defaults to `Chart.appVersion`)                                              | `""`            |
| `imagePullSecrets`           | Global Docker registry secret names as an array                                                | `[]`            |
| `nameOverride`               | String to partially override `common.names.fullname` template (will maintain the release name) | `""`            |
| `fullnameOverride`           | String to fully override `common.names.fullname` template                                      | `""`            |
| `serviceAccount.create`      | Enable the creation of a ServiceAccount                                                        | `false`         |
| `serviceAccount.name`        | Name for the created ServiceAccount                                                            | `""`            |
| `serviceAccount.annotations` | Annotations for the created ServiceAccount                                                     | `{}`            |
| `environmentBase`            | Base environment variables provided to SQLPad pods                                             | See values.yaml |
| `environmentOverride`        | Environment variables used to override those defined in `environmentBase` for SQLPad pods      | `{}`            |
| `runMigration`               | Run SQLPad database migration after chart upgrade                                              | `true`          |
| `podAnnotations`             | Additional pod annotations for SQLPad pods                                                     | `{}`            |
| `podSecurityContext`         | Pod security context for SQLPad pods                                                           | `{}`            |
| `securityContext`            | Security context for SQLPad pods                                                               | `{}`            |
| `service.type`               | SQLPad service type                                                                            | `ClusterIP`     |
| `service.port`               | SQLPad service port                                                                            | `3000`          |
| `resources.limits`           | Resource requests for SQLPad pods                                                              | `{}`            |
| `resources.requests`         | Resource limits for SQLPad pods                                                                | `{}`            |
| `nodeSelector`               | Node labels for SQLPad pods assignment                                                         | `{}`            |
| `tolerations`                | Tolerations for SQLPad pods assignment                                                         | `[]`            |
| `affinity`                   | Affinity for SQLPad pods assignment                                                            | `{}`            |

#### MariaDB

| Parameter                   | Description                                                                          | Value                              |
| --------------------------- | ------------------------------------------------------------------------------------ | ---------------------------------- |
| `mariadb.enabled`           | Enable the installation of MariaDB. If enabled, this database will be used by SQLPad | `true`                             |
| `mariadb.architecture`      | MariaDB architecture (standalone or replication)                                     | `standalone`                       |
| `mariadb.auth.database`     |                                                                                      | `sqlpad`                           |
| `mariadb.auth.username`     |                                                                                      | `sqlpad`                           |
| `mariadb.auth.password`     |                                                                                      | `ae880f3c4541a4aad456eeec2dc3f15e` |
| `mariadb.auth.rootPassword` |                                                                                      | `4d3336a14b1031c9d1eefa3d7e4203d6` |

### License

All files contained within this Helm Chart and the git Repository which contains it are licensed under the MIT license.

View [license information](https://github.com/sqlpad/sqlpad/blob/master/LICENSE.md) for the software provided by this chart.
