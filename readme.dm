# Instalación del Jaeger Operator en Kubernetes

Este documento proporciona instrucciones paso a paso para instalar el Jaeger Operator en un clúster de Kubernetes utilizando Kind y Cert-Manager.

## Prerrequisitos

- Tener instalado [Kind](https://kind.sigs.k8s.io/)
- Tener instalado [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Paso 1: Crear el clúster en Kind

Primero, crea un clúster de Kubernetes utilizando Kind. Puedes usar el siguiente comando:

```sh
kind create cluster --config kind.config.yaml
```

Si deseas especificar un nombre para el clúster, puedes usar:

```sh
kind create cluster -n mvd --config kind.config.yaml
```

## Paso 2: Instalar Cert-Manager

Cert-Manager es necesario para gestionar certificados en Kubernetes. Instálalo utilizando el siguiente comando:

```sh
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
```

Esto instalará Cert-Manager y sus CRDs en tu clúster.

## Paso 3: Instalar el Jaeger Operator

Después de instalar Cert-Manager, procede con la instalación del Jaeger Operator:

1. Crea un namespace para Jaeger:

    ```sh
    kubectl create namespace observability
    ```

2. Instala el Jaeger Operator en el namespace `observability`:

    ```sh
    kubectl create -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.65.0/jaeger-operator.yaml -n observability
    ```

## Paso 4: Verificar la instalación

Para asegurarte de que tanto Cert-Manager como el Jaeger Operator se han instalado correctamente, puedes verificar el estado de los pods y los CRDs:

1. Verifica los pods en el namespace `observability`:

    ```sh
    kubectl get pods -n observability
    ```

2. Verifica los CRDs instalados:

    ```sh
    kubectl get crds
    ```

Deberías ver algo similar a lo siguiente:

```sh
NAME                                  CREATED AT
certificaterequests.cert-manager.io   2025-02-10T15:17:35Z
certificates.cert-manager.io          2025-02-10T15:17:35Z
challenges.acme.cert-manager.io       2025-02-10T15:17:35Z
clusterissuers.cert-manager.io        2025-02-10T15:17:35Z
issuers.cert-manager.io               2025-02-10T15:17:35Z
jaegers.jaegertracing.io              2025-02-10T14:35:38Z
orders.acme.cert-manager.io           2025-02-10T15:17:35Z
```

## Paso 5: Esperar a que el Jaeger Operator esté listo

Espera a que el Jaeger Operator esté listo utilizando el siguiente comando:

```sh
kubectl wait --namespace observability --for=condition=ready pod -l name=jaeger-operator --timeout=90s
```


 kubectl apply -f  jaeger.yaml


## Conclusión

Siguiendo estos pasos, habrás instalado correctamente el Jaeger Operator en tu clúster de Kubernetes. Ahora puedes proceder a configurar y utilizar Jaeger para el rastreo distribuido en tus aplicaciones.
