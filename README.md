# Robot Framework with Playwright tests

In this project I demonstrate some features of Robot Framework and Playwright framework,for automation E2E tests.

This project includes:

- Frameworks:
    - Robot Framework
    - Playwright


- Features:
    - Authenticated test sessions with signed states
    - Screenshot on fail and attach to reporter
    - Generate trace file
    - Using trace file for debug test
    - Variable files and custom Keyword
    
## Demo Pages
For these tests I use a Sauce Labs demo app which can be found here: [Sauce Demo](https://www.saucedemo.com/)

## Requirements
- Python >= 3.9 - [How install Python](https://www.python.org/downloads/)
- Pip >= 21.3.x - [How install pip](https://pip.pypa.io/en/stable/installing/)
- Node >= 18.17 [How install Node](https://nodejs.org/en/download)

## Getting Started
Create a virtual environment:

```bash
$ python -m venv venv
$ source venv/bin/activate
```

Install dependencies:

```bash
$ pip3 install --no-cache-dir -r requirements.txt
```

## Configure Browsers:
```bash
$ rfbrowser init
```

## To run tests in Chrome (for headless mode change HEADLESS to True, or change de variable value in tests/resources/system_variables.py )
```bash
$ robot -v BROWSER:chromium -v HEADLESS:False -d ./logs tests
```

## To run tests in firefox Browser:
```bash
$ robot -v BROWSER:firefox -d ./logs tests
```

## Suite configuration, Setup And TearDown
In file tests/__init__.robot, there a code responsible for create state session files e generate browser sessions logged with users form tests/fixtures/users.json ho is used for all tests in folder tests 

```
# __init__.robot
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

```
## Trace file for debug
 Trace file is saved on logs/traces

To open a trace file:

```sh
rfbrowser show-trace -F logs/traces/Add\ a\ product\ to\ cart.zip
```
