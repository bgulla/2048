# 2048

Forked from [gabrielecirulli/2048](https://github.com/gabrielecirulli/2048).

## Deployment

### Docker

```bash
docker run -p 8080:8080 ghcr.io/bgulla/2048:latest
```

### Helm (local)

```bash
make install
```

### Rancher Fleet (fleet.yaml bundle)

Add a `fleet.yaml` to a GitRepo bundle pointed at this repo:

```yaml
defaultNamespace: 2048

helm:
  repo: https://bgulla.github.io/charts
  chart: kitchensink
  releaseName: 2048
  takeOwnership: true
  values:
    fullnameOverride: 2048
    image:
      repository: ghcr.io/bgulla/2048
      tag: latest
    service:
      port: 8080
    podSecurityContext:
      runAsNonRoot: true
      runAsUser: 65532
      runAsGroup: 65532
    securityContext:
      allowPrivilegeEscalation: false
      runAsNonRoot: true
      runAsUser: 65532
      capabilities:
        drop: [ALL]

targets:
  - clusterSelector:
      matchLabels:
        management.cattle.io/cluster-display-name: your-cluster
```

Add this repo to Fleet under **Rancher > Continuous Delivery > Git Repos**, pointing to `github.com/bgulla/2048` with the path set to the directory containing `fleet.yaml`.

### HelmOp (Fleet CRD)

Apply directly to your fleet-default namespace:

```yaml
apiVersion: fleet.cattle.io/v1alpha1
kind: HelmOp
metadata:
  name: 2048
  namespace: fleet-default
spec:
  defaultNamespace: 2048
  helm:
    releaseName: 2048
    repo: https://bgulla.github.io/charts
    chart: kitchensink
    takeOwnership: true
    values:
      fullnameOverride: 2048
      image:
        repository: ghcr.io/bgulla/2048
        tag: latest
      service:
        port: 8080
      podSecurityContext:
        runAsNonRoot: true
        runAsUser: 65532
        runAsGroup: 65532
      securityContext:
        allowPrivilegeEscalation: false
        runAsNonRoot: true
        runAsUser: 65532
        capabilities:
          drop: [ALL]
  targets:
    - clusterSelector:
        matchLabels:
          management.cattle.io/cluster-display-name: your-cluster
```

```bash
kubectl apply -f helmop.yaml
```

Fleet will reconcile the HelmOp and install the release on any cluster matching the target selector.

## License

MIT — see [LICENSE.txt](LICENSE.txt)
