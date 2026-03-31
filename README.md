# 2048
A small clone of [1024](https://play.google.com/store/apps/details?id=com.veewo.a1024), based on [Saming's 2048](http://saming.fr/p/2048/) (also a clone). 2048 was indirectly inspired by [Threes](https://asherv.com/threes/).

Made just for fun. [Play it here!](http://gabrielecirulli.github.io/2048/)

The official app can also be found on the [Play Store](https://play.google.com/store/apps/details?id=com.gabrielecirulli.app2048) and [App Store!](https://itunes.apple.com/us/app/2048-by-gabriele-cirulli/id868076805)

### Contributions

[Anna Harren](https://github.com/iirelu/) and [sigod](https://github.com/sigod) are maintainers for this repository.

Other notable contributors:

 - [TimPetricola](https://github.com/TimPetricola) added best score storage
 - [chrisprice](https://github.com/chrisprice) added custom code for swipe handling on mobile
 - [marcingajda](https://github.com/marcingajda) made swipes work on Windows Phone
 - [mgarciaisaia](https://github.com/mgarciaisaia) added support for Android 2.3

Many thanks to [rayhaanj](https://github.com/rayhaanj), [Mechazawa](https://github.com/Mechazawa), [grant](https://github.com/grant), [remram44](https://github.com/remram44) and [ghoullier](https://github.com/ghoullier) for the many other good contributions.

### Screenshot

<p align="center">
  <img src="https://cloud.githubusercontent.com/assets/1175750/8614312/280e5dc2-26f1-11e5-9f1f-5891c3ca8b26.png" alt="Screenshot"/>
</p>

That screenshot is fake, by the way. I never reached 2048 :smile:

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

## Contributing
Changes and improvements are more than welcome! Feel free to fork and open a pull request. Please make your changes in a specific branch and request to pull into `master`! If you can, please make sure the game fully works before sending the PR, as that will help speed up the process.

You can find the same information in the [contributing guide.](https://github.com/gabrielecirulli/2048/blob/master/CONTRIBUTING.md)

## License
2048 is licensed under the [MIT license.](https://github.com/gabrielecirulli/2048/blob/master/LICENSE.txt)

## Donations
I made this in my spare time, and it's hosted on GitHub (which means I don't have any hosting costs), but if you enjoyed the game and feel like buying me coffee, you can donate at my BTC address: `1Ec6onfsQmoP9kkL3zkpB6c5sA4PVcXU2i`. Thank you very much!
