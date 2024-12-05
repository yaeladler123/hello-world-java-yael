# JAVA Project Structure Example

This project is a reference model/exemplar of a Java project/repository
that facilitates/enables high-maturity CI, CD, DevOps, etc. development practices.
It is a 'real-world project in miniature' that attempts to be as simple as possible but also non-trivial and useful.
It attempts to be as fully-functional, complete, and interactive as possible,
yet also remain 'lean' enough to be useful as a blueprint, archetype, and reference model for other projects to emulate.


## Overview of Goals/Purpose/Features/Benefits

This project aims to utilize concourse pipelines to achieve/demonstrate the following goals:

- Build Java application using gradle
    - Run "./gradlew build" which read java scripts inside src/main/java/<application_name>/ folder and then build and deploy java artifact to build/libs/ folder
- Automate tests
    - JUnit tests
    - Java Lint tests
    - Code coverage tests
- Publish test results to metrics servers (Sonarqube in this case)
- Publish Java artifact to storage servers (S3 in this case)
- Publish slack message annoucing pipeline status to developers
- Create developmental Java boshrelease for the application
    - Invoke gr-cli binary to read *ci* and *deployment-templates* folders to create the developmental Java boshrelease for the application
    - Upload the created boshrelease to a designated bosh director
- Deploy and test the developmental java boshrelease
    - Instruct bosh director to launch new servers on a designated platform (AWS for now, though we do have plan to support Azure and GCE)
    - Instruct bosh director to deploy the developmental Java boshrelease to the new servers and start the Java application
    - Run tests to validate the Java application performance
- Create final Java boshrelease for the application and deploy to production environment
    - Once the tests all pass, invoke gr-cli and bosh to create final Java boshrelease for the application
    - Upload the new boshrelease to the same bosh director
    - Instruct bosh director to launch new server, deploy the final Java boshrelease to it and start the Java application

**Note:** For more information, refer to the other README.md files located throughout this project.


## Usage Examples

**Note:** The following examples are intended to help new users get started quickly.
Refer to the other README.md files for more info.

### Build the project

From the './' folder:
```
$ ./gradlew clean build
$
$ ls ./build/libs/hello-world-java.jar
$ ls ./build/libs/hello-world-java-javadoc.jar
$ ls ./build/libs/hello-world-java-sources.jar
$
$ open ./build/docs/javadoc/index.html
$ open ./build/docs/javadoc/index-all.html
$ open ./build/docs/javadoc/overview-tree.html
```

The app's Java source files are located in the
*./src/main/java/<application_name>/* folder.

The build-generated artifacts are created in the *./build/* folder.


### Run Tests and Checks/Inspections

From the './' folder:
```
$ ./gradlew clean build test check jacocoTestReport
$
$ cat ./build/test-results/test/TEST-MyTest.xml
$ open ./build/reports/tests/test/index.html
$
$ cat ./build/reports/jacoco/test/jacocoTestReport.xml
$ cat ./build/reports/jacoco/test/jacocoTestReport.csv
$ open ./build/reports/jacoco/html/index.html
$
$ cat ./build/reports/checkstyle/main.xml
$ open ./build/reports/checkstyle/main.html
$ cat ./build/reports/checkstyle/test.xml
$ open ./build/reports/checkstyle/test.html
$ cat ./build/reports/findbugs/main.xml
$ cat ./build/reports/jdepend/main.xml
$ cat ./build/reports/jdepend/test.xml
$ cat ./build/reports/pmd/main.xml
$ open ./build/reports/pmd/main.html
$ cat ./build/reports/spotbugs/main.xml
```


### Run the app

From the './' folder:
```
$ ./gradlew bootRun
```

### Other useful Gradle commands:

From the './' folder:
```
$ ./gradlew tasks
$ ./gradlew tasks --all
$
$ ./gradlew --dry-run clean build
$
$ ./gradlew clean
$ ./gradlew build
$ ./gradlew test
$ ./gradlew check
```

### Make-based commands:

For those unfamiliar with Gradle, a project Makefile is also provided.
The Makefile is provided primarily as a form of 'runnable documentation'
for the Gradle-based build commands, processes, and artifacts.
However, the Makefile does also provide a number of make targets
(mostly related to environment troubleshooting)
that do not correspond to any Gradle tasks.

For more info about the functionality available via the Makefile,
run either of the following commands:

From the './' folder:
```
$ ./make
$ ./make help-make
```

Examples of executing Gradle tasks via the Makefile are shown below:

From the './' folder:
```
$ ./make all
$ ./make build
$ ./make clean build test check
```


## See Also:


### Additional README files within this project

More info about various aspects of this project can be found in the README files of each folder:

Project README Files:
- [/README.md (this file)](./README.md)
    - [/ci/README.md](./ci/README.md)
    - [/deployment_templates/README.md](./deployment_templates/README.md)


### Additional Resources:

For more info, refer to the following:

References:
-
