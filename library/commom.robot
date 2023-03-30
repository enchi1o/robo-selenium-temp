*** Settings ***
Library           SeleniumLibrary
Test Teardown     Close Browser

*** Variables ***
${URL}            https://www.google.com
${txtSearch}      //*[@name="q"]

*** Test Cases ***
Open Browser
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage    #disable page crash of chrome
    Call Method    ${chrome_options}    add_argument    --no-sandbox    #disable sandbox mode
    Call Method    ${chrome_options}    add_argument    --headless    #run with no web browser
    Create Webdriver    driver_name=Chrome    alias=google    chrome_options=${chrome_options}    executable_path=/usr/local/bin/chromedriver
    Set Window Size    1200    1000    #run on docker can't use Maximize Browser Window
    Go To    ${URL}
    Wait Until Element Is Visible    ${txtSearch}    10s
    Input Text    ${txtSearch}    Robotframework
    Press Keys    ${txtSearch}    RETURN
    Capture Page Screenshot    Robotframework.png
