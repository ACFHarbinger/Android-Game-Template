# helm/

> **Optional.** Only relevant for the optional leaderboards/cloud-save backend.
> Packages (mostly) the same resources as `infra/global/k8s/base/`, for teams that
> prefer `helm install` over `kubectl apply -k`. Pick one, don't run both
> against the same cluster/namespace.

```bash
helm lint infra/global/helm/android-game-template
helm install android-game-template infra/global/helm/android-game-template -f infra/global/helm/android-game-template/values.yaml
```
