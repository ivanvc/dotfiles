all_dirs := $(wildcard */)
all_stows := $(all_dirs) $(patsubst %/,%,$(all_dirs))
xdg_config_stows := $(filter-out %.bashrc.d/,$(filter-out %.bashrc.d,$(filter-out _%,$(all_stows))))
root_stows := $(filter _%,$(all_stows))
bashrc_d_stows := $(filter %.bashrc.d,$(all_stows)) $(patsubst %.d,%.d/,$(filter %.bashrc.d,$(all_stows)))
XDG_CONFIG_HOME ?= $$HOME/.config
BASHRC_D_PATH := $$HOME/.bashrc.d
STOW_COMMAND ?= -S

default: all

.PHONY: $(xdg_config_stows)
$(xdg_config_stows):
	target_dir=$(XDG_CONFIG_HOME)/$@; \
	 mkdir -p $$target_dir && \
	 stow -t $$target_dir $(STOW_COMMAND) $@

.PHONY: $(root_stows)
$(root_stows):
	@stow $(STOW_COMMAND) $@

$(HOME)/.bashrc.d:
	mkdir -p $(HOME)/.bashrc.d

.PHONY: $(bashrc_d_stows)
$(bashrc_d_stows): $(HOME)/.bashrc.d
	@stow -t $(BASHRC_D_PATH) $(STOW_COMMAND) $@

.PHONY: all
all: $(filter-out %/,$(all_stows))

.PHONY: targets
targets:
	@echo all_stows=$(all_stows)
	@echo xdg_config_stows=$(xdg_config_stows)
	@echo root_stows=$(root_stows)
	@echo bashrc_d_stows=$(bashrc_d_stows)

.PHONY: uninstall
uninstall: STOW_COMMAND := -D
uninstall: all

.PHONY: lint
lint:
	find . -name '*.sh' -print0 | xargs -I{} -0 shellcheck {}
	find . -executable -a \! -type d -a \! -path '*/.*' -print0 | \
	  xargs -0 -I{} shellcheck {}
