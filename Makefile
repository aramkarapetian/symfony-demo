.PHONY:

REPOSITORY_NAME:="symfony-demo"
APP_VERSION:="v1"

build:
	$(eval REPOSITORY_PATH=`aws ecr describe-repositories --repository-name ${REPOSITORY_NAME} --query 'repositories[*].repositoryUri' --output text`)
	docker-compose run build
	docker build -t $(REPOSITORY_PATH):${APP_VERSION} .
	docker push $(REPOSITORY_PATH):${APP_VERSION}

prepare-infrastructure:
	aws cloudformation create-stack --stack-name symfony-demo-ecr-registry --template-body file://${PWD}/formation/ecr.yml
	aws ecr get-login --no-include-email | sh

deploy:
	aws cloudformation create-stack --stack-name surroundings --template-body file://${PWD}/formation/surroundings.yml
	# aws cloudformation create-stack --stack-name symfony-demo-iam --template-body file://${PWD}/formation/iam.yml --capabilities CAPABILITY_IAM
	# aws cloudformation delete-stack --stack-name symfony-demo-app
	aws cloudformation create-stack --stack-name symfony-demo-app --template-body file://${PWD}/formation/app.yml