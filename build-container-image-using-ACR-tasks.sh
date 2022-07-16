# Example for building a container image using ACR Tasks

# log into your Azure account
az login

# set the appropriate subscription.
# ****** Replace <SubscriptionName>
az account set --subscription "<SubscriptionName>"

# create a resource group for the container registry in eastus2 region
az group create --name az204-acr-rg --location eastus2

# Create the container registry.
# the container registry name must be unique across all of Azure
# ****** Replace <myContainerRegistry>
az acr create --resource-group az204-acr-rg \
    --name <myContainerRegistry> --sku Basic

# Create a local docker file based on hello world
echo FROM mcr.microsoft.com/hello-world > Dockerfile

# build the container image and push it to your container registry just created
# ****** Replace <myContainerRegistry>
az acr build --image sample/hello-world:v1  \
    --registry <myContainerRegistry> \
    --file Dockerfile .

# verify the results by listing the contain images in your container repository
# ****** Replace <myContainerRegistry>
az acr repository list --name <myContainerRegistry> --output table

# list the tags for your newly created image
# ****** Replace <myContainerRegistry>
az acr repository show-tags --name <myContainerRegistry> \
    --repository sample/hello-world --output table

# run the container image
# ****** Replace <myContainerRegistry>
az acr run --registry <myContainerRegistry> \
    --cmd '$Registry/sample/hello-world:v1' /dev/null

# clean up.  Remove the resource group, container registry and container images.
az group delete --name az204-acr-rg --no-wait


