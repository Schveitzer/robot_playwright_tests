*** Settings ***
Library             Browser
Library             OperatingSystem
Library             JSONLibrary
Variables           ./resources/system_variables.py

Suite Setup         Save Loged State File for user in ${file_path}
Suite Teardown      Remove Directory    ${OUTPUT_DIR}/browser/traces/    recursive=True


*** Variables ***
${file_path}            tests/fixtures/users.json
${logo_text}            css=.app_logo
${filed_username}       css=[data-test=\"username\"]
${filed_password}       css=[data-test=\"password\"]
${login_button}         css=[data-test=\"login-button\"]


*** Keywords ***
Save Loged State File for user in ${file_path}
# Keyword ho interate over ${file_path}, get user and password, do login and save a state file for eatch user

    # Load json file
    ${json_data}=    Load Json From File    ${file_path}

    FOR    ${user}    IN    @{json_data['users']}
        ${username}=     Set Variable    ${user['user']}
        ${password}=     Set Variable    ${user['password']}
        New Browser      ${BROWSER}    headless=${HEADLESS}
        New Context      viewport={'width': ${SCREEN_WIDTH}, 'height': ${SCREEN_HEIGHT}}
        New Page         ${BASE_URL}
        Type Text        ${filed_username}    ${username}    clear=True
        Type Text        ${filed_password}    ${password}    clear=True
        Click            ${login_button}
        Get Text         ${logo_text}    contains    Swag Labs
        ${state_file}=    Save Storage State
        Move File    ${state_file}    ${OUTPUTDIR}/browser/state/${username}.json
        Close Context
        # Chame a keyword de login com os dados do usuário atual
    END
