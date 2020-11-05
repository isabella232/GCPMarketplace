include ../crd.Makefile
include ../gcloud.Makefile
include ../var.Makefile
include ../images.Makefile

CHART_NAME := raven
APP_ID ?= $(CHART_NAME)

TRACK ?= v1.0
POSTGRESQL_TAG ?= v1.0

# VERIFY_WAIT_TIMEOUT = 60

SOURCE_REGISTRY ?= gcr.io/dm-eagle/click-to-deploy/raven
IMAGE_RAVEN ?= $(SOURCE_REGISTRY)/raven-web:$(TRACK)
IMAGE_RAVEN_POSTGRESQL ?= $(SOURCE_REGISTRY)/raven-postgresql:$(POSTGRESQL_TAG)

# Main image
image-$(CHART_NAME) := $(call get_sha256,$(IMAGE_RAVEN))

# List of images used in application
ADDITIONAL_IMAGES := raven-postgresql

# Additional images variable names should correspond with ADDITIONAL_IMAGES list
image-raven-postgresql := $(call get_sha256,$(IMAGE_RAVEN_POSTGRESQL))

C2D_CONTAINER_RELEASE := $(call get_c2d_release,$(image-$(CHART_NAME)))

BUILD_ID := $(shell date --utc +%Y%m%d-%H%M%S)
RELEASE ?= $(C2D_CONTAINER_RELEASE)-$(BUILD_ID)
NAME ?= $(APP_ID)-1


APP_PARAMETERS ?= { \
  "name": "$(NAME)", \
  "namespace": "$(NAMESPACE)" \
}

# c2d_deployer.Makefile provides the main targets for installing the application.
# It requires several APP_* variables defined above, and thus must be included after.
include ../c2d_deployer.Makefile


# Build tester image
app/build:: .build/$(CHART_NAME)/tester
