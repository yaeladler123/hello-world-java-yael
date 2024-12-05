#####

.DEFAULT_GOAL := help-make

#####

# Make macros and functions
#TODO=@echo "ERROR: [$@] not yet implemented."

#####

# targets: about-*

# Note: Each of the 'about-*' targets outputs various info about a particular aspect of the system/environment.
# These targets are intended to facilitate easier debugging, logging, troubleshooting, and similar activities.
# The generated output may include a variety of information, including: diagnostics, status, etc.


.PHONY: about-make
about-make: ## Show make-related info
	which make
	make --version

#see: [C++ etc.: Print all variables in a Makefile](http://cplusplusetc.blogspot.com/2012/07/print-all-variables-in-makefile.html)
#see: [Dumping Every Makefile Variable | CMCrossroads](https://www.cmcrossroads.com/article/dumping-every-makefile-variable)
.PHONY: about-make-printvars
about-make-printvars: #-# Prints the value of all make variables
#	$(STARTING)
	@$(foreach V,$(sort $(.VARIABLES)), $(if $(filter-out environment% default automatic, $(origin $V)),$(warning $V=$($V) ($(value $V)))))
#	$(DONE)

#.PHONY: debug-make
#debug-make: about-make-printvars #-# Outputs various info to help in debugging this Makefile
#	$(STARTING)
#	$(DONE)

.PHONY: about-make-vars
about-make-vars: about-make-printvars ## Shows the values of all make variables

.PHONY: about-dir
about-dir: ## Show info about the current dir
	@pwd
#	@tree | tail -n 1

.PHONY: about-env
about-env: ## Show info about the current environment
	env

#.PHONY: about-sys
#about-sys: ## Show info about the current system
#	$(TODO)

# see: [Get current users username in bash? - Stack Overflow](https://stackoverflow.com/questions/19306771/get-current-users-username-in-bash)
.PHONY: about-user
about-user: ## Show info about the current user
# Note: id -F is NOT an OS-portable flag.
	id -F 2> /dev/null || whoami 2> /dev/null || id -u -n
# Note: -p is NOT an OS-portable flag.
	id -p 2> /dev/null || id -G
#	who
#	logname

.PHONY: about-git
about-git: ## Show git-related info
	which git
	git --version
	git status
	git config --list
#	git shortlog

.PHONY: about-go
about-go: ## Show golang-related info
	go version
	go list || echo "ERROR: go list exited with an error!"
	go env
	@echo
	@echo 'Go sub-packages:'
	go list -f '{{if (or .TestGoFiles .XTestGoFiles | len)}}{{.ImportPath}}{{end}}' ./...
	@echo
	@echo 'Go sub-packages (with Test files):'
	go list -f '{{if (or .TestGoFiles .XTestGoFiles | len)}}{{.ImportPath}}{{end}}' ./...

JAVA ?= java

.PHONY: about-java
about-java: ## Show Java-related info
	$(JAVA) -version

GRADLE ?= ./gradlew

.PHONY: about-gradle
about-gradle: ## Show Gradle-related info
	$(GRADLE) --version

.PHONY: about-gradle-tasks
about-gradle-tasks: ## Print info about the project's supported Gradle tasks (runs `$(GRADLE) tasks --all`)
	$(GRADLE) tasks --all

#####

# targets: help-related

.PHONY: help-make
help-make: help-make-list-targets ## Show help info about this Makefile

.PHONY: help-make-usage
help-make-usage: ## Show usage info for this Makefile
	@make --help | head -n 1
	@echo "       Refer to \`make --help\` for more info."
	@echo "       Refer to \`make help-make\` for more info."

# See: [A Self-Documenting Makefile](http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html)
# See: [Test Double | Our Blog | Makefile Usability Tips](http://blog.testdouble.com/posts/2017-04-17-makefile-usability-tips)
.PHONY: help-make-list-targets
help-make-list-targets: #-# Show this list of make targets
# Note: make targets without a '## ' comment are excluded from the output (i.e. internal/private/hidden)
# TODO: enhance this target to show each target only once (and the right one) when a target is overridden.
# TODO: enhance this target to enable frequently-used 'tier 1' targets to be displayed differently than uncommonly used ones. (i.e. Target visibilities in between public and hidden.)
	@make --help | head -n 1
	@echo "       Refer to \`make --help\` for more info."
	@echo "       Refer to \`make help-make-usage\` for more info."
	@echo
	@echo [target] can be any of the following:
# Note: To change the width of the first column, change the '30' in '-30s' to some other number.
	@grep --no-filename -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#####
