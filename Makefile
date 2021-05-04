BUILD_DIR=build
SEARCH_INDEX_FILE=tdm.st
STORK_CONFIG=stork.toml
ANTORA_PLAYBOOK=antora-playbook.yml
ANTORA_OPTIONS=--stacktrace --fetch

clean:
	rm -rf $(BUILD_DIR)

build: clean
	antora $(ANTORA_PLAYBOOK) $(ANTORA_OPTIONS)
	stork build --input $(STORK_CONFIG) --output $(SEARCH_INDEX_FILE)
	cp $(SEARCH_INDEX_FILE) build/site/_/

test-search: build
	stork test --input $(STORK_CONFIG)
