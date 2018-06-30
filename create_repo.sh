#!/usr/bin/env bash

REPO=`aws ecr describe-repositories --repository-name ${REPO_NAME} || ""`
if [ $REPO == "" ]; then
    aws ecr create-repository --repository-name ${REPO_NAME} || echo "success"
fi
#aws elbv2 create-target-group --name test1tg --protocol HTTP --port 80 --vpc-id vpc-b7e5bcdf
