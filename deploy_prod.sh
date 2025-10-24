if [ "$(git rev-parse --abbrev-ref HEAD)" = "main" ]; then
  echo "Branche main —> déploiement"

  rm -Rf ~/.kube
  mkdir ~/.kube
  cat $KUBE_CONFIG > ~/.kube/config
  export KUBECONFIG=~/.kube/config

  sudo helm upgrade --install users ./helm/users --values=helm/users/values.yaml --namespace prod --set image.tag=latest --set service.nodeport=30002
  sudo helm upgrade --install orders ./helm/orders --values=helm/orders/values.yaml --namespace prod --set image.tag=latest --set service.nodeport=30002
  sudo helm upgrade --install gateway ./helm/gateway --values=helm/gateway/values.yaml --namespace prod --set image.tag=latest --set service.nodeport=30002

  kubectl get pods -n prod
  kubectl get svc -n prod
else
  echo "Autre branche —> pas de déploiement"
fi
