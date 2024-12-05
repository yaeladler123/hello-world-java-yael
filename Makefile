#####

# Project-specific vars
GRADLE := ./gradlew

#####

# Make library includes

MAKE_LIB_HELP := ./make.lib.help.mak
include ${MAKE_LIB_HELP}

#####

# File and Artifact vars and targets

# Note: the following 3 vars need to have deferred evaluation, else `make clean && make all` will fail

APP_LIB_JAR = $(wildcard ./build/libs/hello-world-java-v*-bin.jar)
#$(APP_LIB_JAR): #build

APP_LIB_JAR_SOURCE = $(wildcard ./build/libs/hello-world-java-v*-sources.jar)
#$(APP_LIB_JAR_SOURCE): #build

APP_LIB_JAR_JAVADOC = $(wildcard ./build/libs/hello-world-java-v*-javadoc.jar)
#$(APP_LIB_JAR_JAVADOC): #build


APP_BIN_TAR := ./build/distributions/hello-world-java.tar
#$(APP_BIN_TAR): #build

APP_BIN_ZIP := ./build/distributions/hello-world-java.zip
#$(APP_BIN_ZIP): #build

APP_BIN_TAR_BOOT := ./build/distributions/hello-world-java-boot.tar
#$(APP_BIN_TAR_BOOT): #build

APP_BIN_ZIP_BOOT := ./build/distributions/hello-world-java-boot.zip
#$(APP_BIN_ZIP_BOOT): #build


JACOCO_DATA_BIN := ./build/jacoco/test.exec
#$(JACOCO_DATA_BIN): #reports-jacoco

JACOCO_REPORT_XML := ./build/reports/jacoco/test/jacocoTestReport.xml
#$(JACOCO_REPORT_XML): #reports-jacoco

JACOCO_REPORT_HTML_INDEX := ./build/reports/jacoco/html/index.html
#$(JACOCO_REPORT_HTML_INDEX): #reports-jacoco
JACOCO_REPORT_HTML := $(dir ${JACOCO_REPORT_HTML_INDEX})

JACOCO_REPORT_CSV := ./build/reports/jacoco/test/jacocoTestReport.csv
#$(JACOCO_REPORT_CSV): #reports-jacoco


COBERTURA_REPORT_XML := ./build/reports/cobertura/cobertura.xml
#$(COBERTURA_REPORT_XML): #reports-jacobo


TEST_REPORT_XML_DIR := ./build/test-results/test
TEST_REPORT_BIN_DIR := ./build/test-results/test/binary

# Note: There are likely to be multiple/many 'test suite report XML' files per 'test run', and the count is changed by some targets. Ergo, don't use a static variable.
#TEST_REPORT_XML = ./build/test-results/test/TEST-MyTest.xml
#$(TEST_REPORT_XML): #test

TEST_REPORT_HTML_INDEX := ./build/reports/tests/test/index.html
#$(TEST_REPORT_HTML_INDEX): #test
TEST_REPORT_HTML := $(dir ${TEST_REPORT_HTML_INDEX})


CHECKSTYLE_REPORT_XML := ./build/reports/checkstyle/main.xml
#$(CHECKSTYLE_REPORT_XML): #check

CHECKSTYLE_REPORT_HTML_INDEX := ./build/reports/checkstyle/main.html
#$(CHECKSTYLE_REPORT_HTML_INDEX): #check
CHECKSTYLE_REPORT_HTML := $(dir ${CHECKSTYLE_REPORT_HTML_INDEX})

CHECKSTYLE_REPORT_XML_TESTCODE := ./build/reports/checkstyle/test.xml
#$(CHECKSTYLE_REPORT_XML_TESTCODE): #check

CHECKSTYLE_REPORT_HTML_TESTCODE_INDEX := ./build/reports/checkstyle/test.html
#$(CHECKSTYLE_REPORT_HTML_TESTCODE_INDEX): #check
CHECKSTYLE_REPORT_HTML_TESTCODE := $(dir ${CHECKSTYLE_REPORT_HTML_TESTCODE_INDEX})

FINDBUGS_REPORT_XML := ./build/reports/findbugs/main.xml
#$(FINDBUGS_REPORT_XML): #check

JDEPEND_REPORT_XML := ./build/reports/jdepend/main.xml
#$(JDEPEND_REPORT_XML): #check

JDEPEND_REPORT_XML_TESTCODE := ./build/reports/jdepend/test.xml
#$(JDEPEND_REPORT_XML_TESTCODE): #check

PMD_REPORT_XML := ./build/reports/pmd/main.xml
#$(PMD_REPORT_XML): #check

PMD_REPORT_HTML_INDEX := ./build/reports/pmd/main.html
#$(PMD_REPORT_HTML_INDEX): #check
PMD_REPORT_HTML := $(dir ${PMD_REPORT_HTML_INDEX})

SPOTBUGS_REPORT_XML := ./build/reports/spotbugs/main.xml
#$(SPOTBUGS_REPORT_XML): #check

#####

# targets: primary/standard targets

.PHONY: clean
clean: ## Removes build-generated files and artifacts
	$(GRADLE) clean

.PHONY: build
build: ## Builds the app
	$(GRADLE) build

#.PHONY: install
#install: ## Installs the app
#	$(TODO)

.PHONY: run
run: ## Runs the application (runs `$(GRADLE) bootRun`)
	@echo 'To run the app, run: '
	@echo '    `$(GRADLE) bootRun`'
#	$(GRADLE) bootRun

.PHONY: test
test: ## Runs the project's tests (runs `$(GRADLE) test`)
	$(GRADLE) test

.PHONY: check
check: ## Runs various inspections and generates inspection reports (runs `$(GRADLE) check`)
	$(GRADLE) check

.PHONY: reports-jacoco
reports-jacoco: #-# Generates JaCoCo reports (runs `$(GRADLE) jacocoTestReport`)
	$(GRADLE) jacocoTestReport

.PHONY: reports-jacobo
reports-jacobo: #-# Generates a Cobertura-format report from the JaCoCo report (runs `$(GRADLE) jacoboTestReport`)
	$(GRADLE) jacoboTestReport

.PHONY: reports
reports: test check reports-jacobo ## Generates all reports

SONAR_DIR_PATH := ./build/sonar
$(SONAR_DIR_PATH): #-# creates the $(SONAR_DIR_PATH) dir, if/when needed
	mkdir -p $(SONAR_DIR_PATH)/

$(SONAR_DIR_PATH)/test-reports/: $(SONAR_DIR_PATH) #-# creates the $(SONAR_DIR_PATH)/test-reports/ dir, if/when needed
	mkdir -p $(SONAR_DIR_PATH)/test-reports/

.PHONY: sonar-testreports
sonar-testreports: $(SONAR_DIR_PATH)/test-reports/ #-# Copies all 'TEST-*.xml' files to '$(SONAR_DIR_PATH)/test-reports'
	cp $(TEST_REPORT_XML_DIR)/TEST-*.xml '$(SONAR_DIR_PATH)/test-reports/'
# Note: There are likely to be multiple/many 'test suite report XML' files per 'test run', and the list may be modified mid-run by prior targets.
# Ergo, rely on shell-based evaluation of the file list instead of make-based evaluation

# Note: for the conditional 'cp -R' commands within this target, there isn't an OS-portable flag that replicates the behavior of 'mkdir -p'.
# see: [bash - Linux: copy and create destination dir if it does not exist - Stack Overflow](https://stackoverflow.com/questions/1529946/linux-copy-and-create-destination-dir-if-it-does-not-exist/32596855#32596855)
.PHONY: sonar-htmlreports
sonar-htmlreports: $(SONAR_DIR_PATH) #-# Copies the dirs containing various HTML-format reports under '$(SONAR_DIR_PATH)/'
	[ ! -d $(JACOCO_REPORT_HTML) ] || mkdir -p '$(SONAR_DIR_PATH)/html/jacoco' && cp -R $(JACOCO_REPORT_HTML) '$(SONAR_DIR_PATH)/html/jacoco'
	[ ! -d $(TEST_REPORT_HTML) ] || mkdir -p '$(SONAR_DIR_PATH)/html/test' && cp -R $(TEST_REPORT_HTML) '$(SONAR_DIR_PATH)/html/test'
	[ ! -d $(CHECKSTYLE_REPORT_HTML) ] || mkdir -p '$(SONAR_DIR_PATH)/html/checkstyle' && cp -R $(CHECKSTYLE_REPORT_HTML) '$(SONAR_DIR_PATH)/html/checkstyle'
	[ ! -d $(CHECKSTYLE_REPORT_HTML_TESTCODE) ] || mkdir -p '$(SONAR_DIR_PATH)/html/checkstyle.test' && cp -R $(CHECKSTYLE_REPORT_HTML_TESTCODE) '$(SONAR_DIR_PATH)/html/checkstyle.test'
	[ ! -d $(PMD_REPORT_HTML) ] || mkdir -p '$(SONAR_DIR_PATH)/html/pmd' && cp -R $(PMD_REPORT_HTML) '$(SONAR_DIR_PATH)/html/pmd'

.PHONY: sonar-singlefilereports
sonar-singlefilereports: $(SONAR_DIR_PATH) #-# Copies the all 'standalone file' reports into/under '$(SONAR_DIR_PATH)/'
	[ ! -f $(COBERTURA_REPORT_XML) ] || cp $(COBERTURA_REPORT_XML) '$(SONAR_DIR_PATH)/coverage.xml'
	[ ! -f $(CHECKSTYLE_REPORT_XML) ] || cp $(CHECKSTYLE_REPORT_XML) '$(SONAR_DIR_PATH)/report.xml'
	[ ! -f $(APP_LIB_JAR) ] || cp $(APP_LIB_JAR) '$(SONAR_DIR_PATH)/'
	[ ! -f $(APP_LIB_JAR_SOURCE) ] || cp $(APP_LIB_JAR_SOURCE) '$(SONAR_DIR_PATH)/'
	[ ! -f $(APP_LIB_JAR_JAVADOC) ] || cp $(APP_LIB_JAR_JAVADOC) '$(SONAR_DIR_PATH)/'
	[ ! -f $(APP_BIN_TAR) ] || cp $(APP_BIN_TAR) '$(SONAR_DIR_PATH)/'
	[ ! -f $(APP_BIN_ZIP) ] || cp $(APP_BIN_ZIP) '$(SONAR_DIR_PATH)/'
	[ ! -f $(APP_BIN_TAR_BOOT) ] || cp $(APP_BIN_TAR_BOOT) '$(SONAR_DIR_PATH)/'
	[ ! -f $(APP_BIN_ZIP_BOOT) ] || cp $(APP_BIN_ZIP_BOOT) '$(SONAR_DIR_PATH)/'
	[ ! -f $(JACOCO_DATA_BIN) ] || cp $(JACOCO_DATA_BIN) '$(SONAR_DIR_PATH)/coverage.jacoco.exec'
	[ ! -f $(JACOCO_REPORT_XML) ] || cp $(JACOCO_REPORT_XML) '$(SONAR_DIR_PATH)/coverage.jacoco.xml'
	[ ! -f $(JACOCO_REPORT_CSV) ] || cp $(JACOCO_REPORT_CSV) '$(SONAR_DIR_PATH)/coverage.jacoco.csv'
	[ ! -f $(COBERTURA_REPORT_XML) ] || cp $(COBERTURA_REPORT_XML) '$(SONAR_DIR_PATH)/coverage.cobertura.xml'
	[ ! -f $(CHECKSTYLE_REPORT_XML) ] || cp $(CHECKSTYLE_REPORT_XML) '$(SONAR_DIR_PATH)/lint.checkstyle.xml'
	[ ! -f $(CHECKSTYLE_REPORT_XML_TESTCODE) ] || cp $(CHECKSTYLE_REPORT_XML_TESTCODE) '$(SONAR_DIR_PATH)/lint.checkstyle.tests.xml'
	[ ! -f $(FINDBUGS_REPORT_XML) ] || cp $(FINDBUGS_REPORT_XML) '$(SONAR_DIR_PATH)/lint.findbugs.xml'
	[ ! -f $(JDEPEND_REPORT_XML) ] || cp $(JDEPEND_REPORT_XML) '$(SONAR_DIR_PATH)/jdepend.xml'
	[ ! -f $(JDEPEND_REPORT_XML_TESTCODE) ] || cp $(JDEPEND_REPORT_XML_TESTCODE) '$(SONAR_DIR_PATH)/jdepend.tests.xml'
	[ ! -f $(PMD_REPORT_XML) ] || cp $(PMD_REPORT_XML) '$(SONAR_DIR_PATH)/pmd.xml'
	[ ! -f $(SPOTBUGS_REPORT_XML) ] || cp $(SPOTBUGS_REPORT_XML) '$(SONAR_DIR_PATH)/lint.spotbugs.xml'

.PHONY: sonar
sonar: sonar-singlefilereports sonar-testreports sonar-htmlreports #-# Copies build artifact files with Sonar-compatible filenames into a single dir.

.PHONY: gradle-build-test-check
gradle-build-test-check: #-# Runs: `$(GRADLE) build test check jacoboTestReport`
	$(GRADLE) build test check jacoboTestReport

.PHONY: all
all: gradle-build-test-check sonar ## Performs a complete build

#####

