javascript-jasmine session notes

## Repo relationships

Read https://github.com/cyber-dojo/cyber-dojo/blob/master/docs/how-to-contribute-to-start-points.md
This repo builds the Docker image.
The start-point files (source, tests, manifest) live in the repo in
`../../cyber-dojo-start-points/javascript-jasmine` 

## Development loop
In this repo:
1. Edit `docker/Dockerfile.base`
2. Run `./pipe_build_up_test.sh` — builds image, prints new tag at the end
In the start-points repo:
3. Update `image_name` in `start_point/manifest.json`
4. Edit start-point files in `start_point/`
5. Run `run_tests.sh` — verifies red/amber/green

**Important:** 
Never run docker commands directly. 
Only test via `run_tests.sh` (in which the runner containers have no internet access)
The run_tests.sh script simulates three cyber-dojo [test] runs, once for red, once for amber, once for green, and prints a summary for each once that includes the duration. So you don't need to use the `time` command.

## Optimisation: bypass npm run in cyber-dojo.sh

In `start_point/cyber-dojo.sh`, replaced `npm run lint` and `npm run test` with direct calls to the node_modules executables:

```sh
# before
npm run lint
npm run test

# after
/etc/jasmine/node_modules/.bin/eslint --config ${CYBER_DOJO_SANDBOX}/eslint.config.js /**/*.js
/etc/jasmine/node_modules/.bin/nyc /etc/jasmine/node_modules/.bin/jasmine JASMINE_CONFIG_PATH="${CYBER_DOJO_SANDBOX}/jasmine.json"
```

This cut run times from ~8.3–8.7s down to ~3.1–3.7s (~55–63% faster). It also removes the noisy `> lint` / `> test` echo lines that npm prints.

