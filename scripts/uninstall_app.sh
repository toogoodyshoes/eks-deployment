#!/bin/bash

echo "Uninstalling application.."

# Unisntalling modules
modules=("assets" "carts" "catalog" "checkout" "orders" "other" "rabbitmq" "ui")
for ((i = 0; i < ${#modules[@]}; ++i)); do
    module=${modules[i]}

    echo "Uninstalling $module.."
    helm uninstall $module-release-1 ./application/$module/
done

# Deleting namespaces
echo -e "Deleting namespaces..."
helm uninstall namespaces-release-1 --namespace $module