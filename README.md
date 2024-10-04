# example-react
- [![JF-CLI - Query properties](https://github.com/DayOne-Dev/example-react/actions/workflows/jfcli-queryprop.yml/badge.svg)](https://github.com/DayOne-Dev/example-react/actions/workflows/jfcli-queryprop.yml)
- [![JF-CLI - NPM publish & BuildInfo](https://github.com/DayOne-Dev/example-react/actions/workflows/jfcli-npm.yml/badge.svg)](https://github.com/DayOne-Dev/example-react/actions/workflows/jfcli-npm.yml)


### Prerequisite
- Install JFrog CLI: [https://jfrog.com/getcli/](https://jfrog.com/getcli/
- JFrog CLI commands [documentation](https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/install)
- Configure JFrog CLI with the artifactory using command
``````
jf c add --user=<USER_ID> --interactive=true --url=https://<SAAS_HOST>.jfrog.io --overwrite=true
``````

## Build project
### NPM
``````
./jfcli-npm.sh
``````
### run
``````
npm start
``````
### Docker
``````
./jfcli-docker.sh
``````
### run
``````
docker run -d --name example-react -p 3000:3000  <SAAS_HOST>.jfrog.io/krishnam-docker-virtual/example-react-oci:latest
``````
### XRay
``````
./jfcli-xray.sh
``````



# Errors
- <details><summary>Error: EACCES: permission denied, mkdir '/etc/todos'</summary>
Run below command to resolve the error
`````` sudo npm install -g --unsafe-perm=true --allow-root `````` </details>
- <details><summary>Error: Dependencies lock file is not found in /home/runner/work/example-react/example-react. Supported file patterns: package-lock.json,npm-shrinkwrap.json,yarn.lock</summary>
`````` cache-dependency-path: package-lock.json `````` </details>
- <details><summary>error: failed to solve: process "/bin/sh -c npm install" did not complete successfully: exit code: 1</summary>
</details>
