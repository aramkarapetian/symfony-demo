# symfony-demo

Repo will build and deploy bitnami/symfony image based demo app with default controller returning "200 OK".

Will deploy to AWS ECS and currently presumes ECS and Load Balancer is already in place.

There are number of issues with the setup and deployment:
1. base image is not the best, lot of development tools included
2. build is not final and not optimised for CI
3. current infrastructure presumes some services without references so names and ids are hard coded
4. LB security group is managed externally so rules are also adjusted via console
5. there are not proper detailed security setup, security group definitions should be reviewed
6. container image version update is not considered, in fact second run of scripts will fail "already exists" messages
7. auto-scaling rules are not configured, default ones
8. no proper health check setup for containers, need to be coded first
9. credentials are hard coded into container (need to be supplied from Secrets Manager).

## build and push docker image to AWS ECR
`make build`

## prepare infrastructure
`make prepare-infrastructure`

## deploy application
`make deploy`