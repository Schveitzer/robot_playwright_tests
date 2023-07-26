*** Settings ***
Library         Browser
Variables       ./system_variables.py


*** Variables ***
${state_file}=      ${OUTPUTDIR}/browser/state/standard_user.json


*** Keywords ***
Open Home Page Loged With Regular User
    New Context
    ...        viewport={'width': ${SCREEN_WIDTH}, 'height': ${SCREEN_HEIGHT}}
    ...        storageState=${state_file}
    ...        tracing=${OUTPUT_DIR}/traces/${TEST NAME}.zip
    New Page   ${HOME_URL}

Open New Browser
        New Context
    ...        viewport={'width': ${SCREEN_WIDTH}, 'height': ${SCREEN_HEIGHT}}
    ...        tracing=${OUTPUT_DIR}/traces/${TEST NAME}.zip