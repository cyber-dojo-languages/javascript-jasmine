 javascript-jasmine session notes

## Repo relationships

This repo (`cyber-dojo-languages/javascript-jasmine`) builds the Docker image.
The start-point files (source, tests, manifest) live in the partner repo:
`../../cyber-dojo-start-points/javascript-jasmine`

Development loop:
1. Edit `docker/Dockerfile.base` here
2. Run `./pipe_build_up_test.sh` — builds image, prints new tag at the end
3. Update `image_name` in `../../cyber-dojo-start-points/javascript-jasmine/start_point/manifest.json`
4. Edit start-point files in `../../cyber-dojo-start-points/javascript-jasmine/start_point/`
5. Run `../../cyber-dojo-start-points/javascript-jasmine/run_tests.sh` — verifies red/amber/green

The run_tests.sh run a cyber-dojo test submission three times, once for red, once for amber, once for green. It also prints in its output, the duration of each colour's test run.

**Important:** never run docker commands directly. Only test via `run_tests.sh`.
The runner containers have no internet access.

## Optimisation: bypass npm run in cyber-dojo.sh

In `../../cyber-dojo-start-points/javascript-jasmine/start_point/cyber-dojo.sh`, replaced `npm run lint` and `npm run test` with direct calls to the node_modules executables:

```sh
# before
npm run lint
npm run test

# after
/etc/jasmine/node_modules/.bin/eslint --config ${CYBER_DOJO_SANDBOX}/eslint.config.js /**/*.js
/etc/jasmine/node_modules/.bin/nyc /etc/jasmine/node_modules/.bin/jasmine JASMINE_CONFIG_PATH="${CYBER_DOJO_SANDBOX}/jasmine.json"
```

This cut run times from ~8.3–8.7s down to ~3.1–3.7s (~55–63% faster). It also removes the noisy `> lint` / `> test` echo lines that npm prints.

