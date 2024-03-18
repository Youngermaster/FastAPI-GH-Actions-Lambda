# Getting branch names for Git Flow
#get name of GIT branchse => remove 'feature/' if exists and limit to max 20 characters
GIT_BRANCH=$(shell git rev-parse --abbrev-ref HEAD | sed -r 's/[\/]+/-/g' | sed -r 's/feature-//g' | cut -c 1-20)
GIT_TAG=$(shell git tag --points-at HEAD | cut -c 1-3)

#STAGE ?= $(if $(GIT_TAG), $(GIT_TAG), $(GIT_BRANCH))
STAGE ?= prod

AWS_DEFAULT_REGION ?= us-east-1

#==========================================================================
serverless:
	# install serverless framework for Continous Deployment
	npm install -g serverless || true
	sls plugin install -n serverless-python-requirements
	sls plugin install -n serverless-localstack

deps: serverless
	pip install -r requirements.txt

black: deps
	black app/*

code-checks: black

run: deps
	python app/main.py

deploy:
	@echo "======> Deploying to env $(STAGE) <======"
ifeq ($(FUNC),)
	sls deploy --stage $(STAGE) --verbose --region $(AWS_DEFAULT_REGION)
else
	sls deploy --stage $(STAGE) -f $(FUNC) --verbose --region $(AWS_DEFAULT_REGION)
endif

logs: deps
	@echo "======> Getting logs from env $(STAGE) <======"

destroy: deps
	@echo "======> DELETING in env $(STAGE) <======"
	sls remove --stage $(STAGE) --verbose --region $(AWS_DEFAULT_REGION)

ci: code-checks
cd: ci deploy

clean:
	rm -rf .venv .coverage .serverless .pytest_cache serverless deps node_modules htmlcov __pycache__ .ruff_cache .hypothesis
