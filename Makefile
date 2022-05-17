BUILD_DIR=build
ANTORA_PLAYBOOK=antora-playbook-preview.yml

clean:
	rm -rf $(BUILD_DIR)

build: clean
	npx --no-install antora ${ANTORA_PLAYBOOK};cp _redirects ./build/site/;
