#!/bin/bash

# Creating namespaces
echo "Creating namespaces.."
helm install namespaces-release-1 ./application/namespaces/

# Installing app
echo -e "\nInstalling application.."
modules=("assets" "carts" "catalog" "checkout" "orders" "other" "rabbitmq" "ui")
for ((i = 0; i < ${#modules[@]}; ++i)); do
    module=${modules[i]}

    echo -e "\nInstalling $module.."
    helm install $module-release-1 ./application/$module/ --namespace $module
done
