***Settings***
Documentation       Ações da feature de gestão de matricula



***Keywords***
## Forms

Select Students
    [Arguments]     ${name}

    Fill Text       css=input[aria-label=student_id]        ${name}  # preencher o campo para buscar o cara
    click           css=div[id*=option] >> text=${name} 

Select Plan
    [Arguments]     ${title}

    Fill Text       css=input[aria-label=plan_id]        ${title}  # preencher o campo para buscar o cara
    click           css=div[id*=option] >> text=${title} 

Submit Enrolls Form 
    Click           css=button[form=formEnrollment]
    

## Links & Buttons
Go To Form Enrolls
    Click       css=a[href$="matriculas/new"]
    # checkpoint
    Wait For Elements State         css=h1 >> text=Nova matrícula       visible         5  
    #clicou e foi para a subpágina "Nova matrícula

## Validations

Start Data Should Today

    ${start_date}         Get Current Date        result_format=%d/%m/%Y

    Get Attribute         css=input[name=start_date]      value   equal   ${start_date}

End Date Should Be
    [Arguments]           ${days}   ## Adiciona x dias

    ${current_date}       Get Current Date   ## Pega a data atual do sistema 

    ## Pega a data atual e adiciona alguns  dias 
    ${end_date}           Add Time To Date      ${current_date}     ${days} days     result_format=%d/%m/%Y      

    Get Attribute           css=input[name=end_date]        value   equal   ${end_date}  

    



