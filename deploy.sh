#!/usr/bin/env bash
TASKDEF=task-definition.json
#FAMILY=`jq -r .family $TASKDEF`

#Replace the build number and respository URI placeholders with the constants above
sed -e "s;%REGION%;${AWS_DEFAULT_REGION};g" -e "s;%SERVICE_NAME%;${SERVICE_NAME};g" -e "s;%REPOSITORY_URI%;${REPOSITORY_URI}/$REPO_NAME:latest;g" $TASKDEF > ${CI_PROJECT_NAME}.json
#Register the task definition in the repository
aws ecs register-task-definition --family ${FAMILY} --cli-input-json file://${CI_PROJECT_NAME}.json
SERVICES=`aws ecs describe-services --services ${SERVICE_NAME} --cluster ${CLUSTER} | jq '.services[] | select(.status == "ACTIVE")'`
#Get latest revision
REVISION=`aws ecs describe-task-definition --task-definition ${FAMILY} | jq '.taskDefinition.revision'`

#Create or update service
if [ "$SERVICES" == "" ]; then
  echo "entered existing service ${REVISION}"
  DESIRED_COUNT=`aws ecs describe-services --services ${SERVICE_NAME} --cluster ${CLUSTER} | jq '.services[].desiredCount'`
  if [ ${DESIRED_COUNT} = "0" ]; then
    DESIRED_COUNT="1"
  fi
  echo "aws ecs update-service --cluster ${CLUSTER} --service ${SERVICE_NAME} --task-definition ${FAMILY}:${REVISION} --desired-count ${DESIRED_COUNT}"
  aws ecs update-service --cluster ${CLUSTER} --service ${SERVICE_NAME} --task-definition ${FAMILY}:${REVISION} --desired-count ${DESIRED_COUNT}
else
  echo "entered new service"
  aws ecs create-service --service-name ${SERVICE_NAME} --desired-count 1 --task-definition ${FAMILY} --cluster ${CLUSTER}
fi
