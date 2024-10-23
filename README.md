# example-react

 CI/CD | Description | Code | [youtube.com/@DayOneDev](https://youtube.com/@DayOneDev) |
| ------------- |:-------------:| -------------:| -------------:|
| [GitHub Actions](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-npm.yml) | [JF-CLI](https://jfrog.com/getcli/) build with NPM | [![JF-CLI - NPM publish & BuildInfo](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-npm.yml/badge.svg)](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-npm.yml) | Not Yet | 
| [GitHub Actions](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-npm-xray.yml) | [JF-CLI](https://jfrog.com/getcli/) with NPM and Xray | [![JF-CLI with NPM and Xray](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-npm-xray.yml/badge.svg)](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-npm-xray.yml)| Not Yet | 
| [GitHub Actions](https://github.com/DayOne-Dev/example-reactJs/blob/develop/.github/workflows/jfcli-npm-docker.yml) | [JF-CLI](https://jfrog.com/getcli/) build with NPM and Docker | [![JF-CLI with NPM and Docker](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-npm-docker.yml/badge.svg)](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-npm-docker.yml) | Not Yet | 
| [GitHub Actions](https://github.com/DayOne-Dev/example-reactJs/blob/develop/.github/workflows/jfcli-npm-docker-xray.yml) | [JF-CLI](https://jfrog.com/getcli/) with NPM, Docker, and Xray | [![JF-CLI with NPM, Docker, and Xray](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-npm-docker-xray.yml/badge.svg)](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-npm-docker-xray.yml) | Not Yet | 
| [GitHub Actions](https://github.com/DayOne-Dev/example-reactJs/blob/develop/.github/workflows/jfcli-queryprop.yml) | [JF-CLI](https://jfrog.com/getcli/) to Query properties | [![JF-CLI - Query properties](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-queryprop.yml/badge.svg)](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/jfcli-queryprop.yml) | Not Yet | 
| [GitHub Actions](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/frogbot-scan-repository.yml) | JFrog [Frogbot](https://github.com/jfrog/frogbot) Scan and Fix | [![Frogbot Scan and Fix](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/frogbot-scan-repository.yml/badge.svg)](https://github.com/DayOne-Dev/example-reactJs/actions/workflows/frogbot-scan-repository.yml) | Not Yet | 
| Shell Script | [JF-CLI](https://jfrog.com/getcli/) build with NPM | [jfcli-npm.sh](https://github.com/DayOne-Dev/example-reactJs/blob/develop/jfcli-npm.sh) | Not Yet | 
| Shell Script | [JF-CLI](https://jfrog.com/getcli/) build with NPM + Xray| [jfcli-npm-xray.sh](https://github.com/DayOne-Dev/example-reactJs/blob/develop/jfcli-npm-xray.sh) | Not Yet |


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
