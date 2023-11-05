#!/bin/bash

if [ "x$1" = "xrun" ]; then
    minikube start --driver=virtualbox --profile "$PROJECT_NAME"
    skaffold dev

elif [ "x$1" = "xstop" ]; then
    skaffold delete
    minikube stop --profile "$PROJECT_NAME"

elif [ "x$1" = "xlogs" ]; then
    NAMESPACES=("alloydb")
    for NS in ${NAMESPACES[@]}; do
        POD_NAME=$(kubectl get pods -o custom-columns=":metadata.name" -n "$NS" | grep "$2")
        if [ "$POD_NAME" != "" ]; then
            echo "[namespace: $NS, pod: $POD_NAME] logs..."
            kubectl logs "$POD_NAME" -n "$NS"
        fi
    done

elif [ "x$1" = "xdashboard" ]; then
    minikube dashboard --profile "$PROJECT_NAME"

elif [ "x$1" = "xdestroy" ]; then
    minikube delete --profile "$PROJECT_NAME"

else
    echo "You have to specify which action to be excuted. [ run / stop / logs / dashboard / destroy ]" 1>&2
    exit 1
fi
