
# TARGETS #

#/
# Runs JavaScript benchmarks consecutively.
#
# ## Notes
#
# -   This recipe assumes that benchmark files can be run via Node.js.
# -   This recipe is useful when wanting to glob for JavaScript benchmark files (e.g., run all JavaScript benchmarks for a particular package).
#
#
# @param {string} [BENCHMARKS_FILTER] - file path pattern (e.g., `.*/utils/group-by/.*`)
#
# @example
# make benchmark-javascript
#
# @example
# make benchmark-javascript BENCHMARKS_FILTER=.*/utils/group-by/.*
#/
benchmark-javascript: $(NODE_MODULES)
	$(QUIET) $(FIND_BENCHMARKS_CMD) | grep '^[\/]\|^[a-zA-Z]:[/\]' | while read -r file; do \
		echo ""; \
		echo "Running benchmark: $$file"; \
		NODE_ENV=$(NODE_ENV_BENCHMARK) \
		NODE_PATH=$(NODE_PATH_BENCHMARK) \
		$(NODE) $$file || exit 1; \
	done

.PHONY: benchmark-javascript

#/
# Runs a specified list of JavaScript benchmarks consecutively.
#
# ## Notes
#
# -   This recipe assumes that benchmark files can be run via Node.js.
# -   This recipe is useful when wanting to run a list of JavaScript benchmark files generated by some other command (e.g., a list of changed JavaScript benchmark files obtained via `git diff`).
#
#
# @param {string} FILES - list of JavaScript benchmark file paths
#
# @example
# make benchmark-javascript-files FILES='/foo/benchmark.js /bar/benchmark.js'
#/
benchmark-javascript-files: $(NODE_MODULES)
	$(QUIET) for file in $(FILES); do \
		echo ""; \
		echo "Running benchmark: $$file"; \
		NODE_ENV=$(NODE_ENV_BENCHMARK) \
		NODE_PATH=$(NODE_PATH_BENCHMARK) \
		$(NODE) $$file || exit 1; \
	done

.PHONY: benchmark-javascript-files
