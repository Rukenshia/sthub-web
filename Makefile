INSTANCE_ID ?= i-0e94330a230c525ae
REGION ?= eu-central-1
AVAILABILITY_ZONE ?= ${REGION}c

guard-%:
	@if [ -z '${shell echo ${*}}' ]; then echo '[!] Environment variable $* not set' && exit 1; fi

.PHONY: build
build:
	MIX_ENV=prod mix compile
	npm install --prefix ./assets
	npm run deploy --prefix ./assets
	mix phx.digest

.PHONY: release
release: guard-SECRET_KEY_BASE guard-DATABASE_URL build
	MIX_ENV=prod mix release
	
.PHONY: deploy
deploy: build release

.PHONY: upload-key
upload-key:
	aws ec2-instance-connect send-ssh-public-key \
		--region ${REGION} \
		--instance-id ${INSTANCE_ID} \
		--availability-zone ${AVAILABILITY_ZONE} \
		--instance-os-user ec2-user \
		--ssh-public-key file://${HOME}/.ssh/aws_instance_connect.pub

.PHONY: connect
connect: upload-key
	ssh -i ${HOME}/.ssh/aws_instance_connect ec2-user@testhub.in.fkn.space

.PHONY: upload-release
upload-release: upload-key guard-DATABASE_URL guard-SECRET_KEY_BASE
	tar --exclude "deps" --exclude "_build" -czf sthub-web.tar.gz *
	scp -i ${HOME}/.ssh/aws_instance_connect ./sthub-web.tar.gz ec2-user@testhub.in.fkn.space:/home/ec2-user/sthub-web/sthub-web.tar.gz
	ssh -i ${HOME}/.ssh/aws_instance_connect ec2-user@testhub.in.fkn.space "cd sthub-web && tar -xzf sthub-web.tar.gz && rm sthub-web.tar.gz && mix deps.get && DATABASE_URL="${DATABASE_URL}" SECRET_KEY_BASE="${SECRET_KEY_BASE}" MIX_ENV=prod mix release --overwrite && sudo systemctl stop sthub && _build/prod/rel/sthub/bin/sthub eval 'StHub.Release.migrate' && sudo systemctl start sthub"
	rm sthub-web.tar.gz