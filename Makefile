all_dirs := $(wildcard */)
all_stows := $(all_dirs) $(patsubst %/,%,$(all_dirs))
combined_stows := $(filter-out %.profile.d/ %.profile.d %.config %.config/ %.bin %.bin/,$(all_stows))

combined_stows_config := $(sort $(addsuffix /config,$(combined_stows:%/=%)))
combined_stows_profile_d := $(sort $(addsuffix /profile.d,$(combined_stows:%/=%)))
combined_stows_bin := $(sort $(addsuffix /bin,$(combined_stows:%/=%)))

xdg_config_stows := $(filter %.config %.config/,$(all_stows))
profile_d_stows := $(filter %.profile.d %.profile.d/,$(all_stows))
bin_stows := $(filter %.bin %.bin/,$(all_stows))

XDG_CONFIG_HOME ?= $(HOME)/.config
PROILE_D_PATH := $(XDG_CONFIG_HOME)/profile.d
BIN_PATH := $(HOME)/.local/bin
STOW_COMMAND ?= -S
REQ_DIRS := $(PROILE_D_PATH) $(BIN_PATH)

default: all

$(REQ_DIRS):
	mkdir -p $@

.PHONY: $(combined_stows)
$(combined_stows):
	if [ -d "$(@:%/=%)/config" ]; then $(MAKE) "$(@:%/=%)/config"; fi
	if [ -d "$(@:%/=%)/profile.d" ]; then $(MAKE) "$(@:%/=%)/profile.d"; fi
	if [ -d "$(@:%/=%)/bin" ]; then $(MAKE) "$(@:%/=%)/bin"; fi
	for file in $(wildcard $(@:%/=%)/_*); do \
		if [ -d "$$file" ]; then \
			if [ ! -d "$(HOME)/.$${file#$(@:%/=%)/_}" ]; then \
				echo mkdir -p "$(HOME)/.$${file#$(@:%/=%)/_}"; \
			fi; \
			for f in $$file/*; do \
				ln --symbolic --force $(PWD)/$$f $(HOME)/."$${file#$(@:%/=%)/_}"/; \
			done; \
		else \
			ln --symbolic --force $(PWD)/$$file $(HOME)/."$${file#$(@:%/=%)/_}"; \
		fi; \
	done

.PHONY: $(combined_stows_config)
$(combined_stows_config):
	target_dir=$(XDG_CONFIG_HOME)/$(@:/config=); \
	 mkdir -p $$target_dir && \
	 cd $(@:%/config=%) && stow -t $$target_dir $(STOW_COMMAND) config

.PHONY: $(combined_stows_profile_d)
$(combined_stows_profile_d): $(REQ_DIRS)
	cd $(@:%/profile.d=%) && stow -t $(PROILE_D_PATH) $(STOW_COMMAND) profile.d

.PHONY: $(combined_stows_bin)
$(combined_stows_bin): $(REQ_DIRS)
	cd $(@:%/bin=%) && stow -t $(BIN_PATH) $(STOW_COMMAND) bin

.PHONY: $(profile_d_stows)
$(profile_d_stows): $(REQ_DIRS)
	@stow -t $(PROILE_D_PATH) $(STOW_COMMAND) $@

.PHONY: $(bin_stows)
$(bin_stows): $(REQ_DIRS)
	@stow -t $(BIN_PATH) $(STOW_COMMAND) $@

.PHONY: $(xdg_config_stows)
$(xdg_config_stows):
	target_dir=$(XDG_CONFIG_HOME)/$(patsubst %.config,%,$(@:%/=%)); \
	 mkdir -p $$target_dir && \
	 stow -t $$target_dir $(STOW_COMMAND) $@

.PHONY: all
all: $(filter-out %/,$(all_stows))

.PHONY: restow
restow:
	@if [ -z "$(DIR)" ]; then echo "Please provide the \$$DIR variable"; exit 1; fi
	$(MAKE) $(DIR) STOW_COMMAND=-D
	$(MAKE) $(DIR)

.PHONY: uninstall
uninstall: STOW_COMMAND := -D
uninstall: all

.PHONY: lint
lint:
	find . -name '*.sh' -print0 | xargs -I{} -0 shellcheck {}
	find . -executable -a \! -type d -a \! -path '*/.*' -print0 | \
	  xargs -0 -I{} shellcheck {}

.PHONY: targets
targets:
	@echo all_dirs=$(all_dirs)
	@echo all_stows=$(all_stows)
	@echo combined_stows=$(combined_stows)
	@echo combined_stows/config: $(combined_stows_config):
	@echo combined_stows/profile.d: $(combined_stows_profile_d):
	@echo profile_d_stows=$(profile_d_stows)
	@echo xdg_config_stows=$(xdg_config_stows)
	@echo bin_stows=$(bin_stows)
	@echo REQ_DIRS=$(REQ_DIRS)
