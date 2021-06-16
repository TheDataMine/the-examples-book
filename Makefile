BUILD_DIR=build
ANTORA_PLAYBOOK=antora-playbook.yml
ANTORA_OPTIONS=--stacktrace --fetch

clean:
	rm -rf $(BUILD_DIR)

build: clean
	antora $(ANTORA_PLAYBOOK) $(ANTORA_OPTIONS)
