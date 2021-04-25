***Settings***
Documentation       Ações da feature gestão de alunos

***Variables***  ##so crio essa estrutura dentro do app actions se for necessário 
${NAME_FIELD}       css=input[name=name]
${EMAIL_FIELD}      css=input[name=email]     
${AGE_FIELD}        css=input[name=age]
${WEIGHT_FIELD}     css=input[name=weight]
${FEET_TALL}        css=input[name=feet_tall] 

***Keywords***

## Forms
Submit Student Form  ## submete formulário de aluno 
   Click           xpath=//button[contains(text(), "Salvar")]   ## evento de click


New Student
    [Arguments]     ${student}
    #${name}     ${email}       ${age}       ${weight}       ${feet_tall}

    Fill Text       ${NAME_FIELD}        ${student.name}
    Fill Text       ${EMAIL_FIELD}       ${student.email}
    Fill Text       ${AGE_FIELD}         ${student.age}
    Fill Text       ${WEIGHT_FIELD}      ${student.weight}
    Fill Text       ${FEET_TALL}         ${student.feet_tall}

    Submit Student Form

Update A Student
    [Arguments]     ${student}
    #${name}     ${email}       ${age}       ${weight}       ${feet_tall}

    Fill Text       ${NAME_FIELD}        ${student['name']}
    Fill Text       ${EMAIL_FIELD}       ${student['email']}
    Fill Text       ${AGE_FIELD}         ${student['age']}
    Fill Text       ${WEIGHT_FIELD}      ${student['weight']}
    Fill Text       ${FEET_TALL}         ${student['feet_tall']}

    Submit Student Form

## Links & Buttons
# ações da pagina referente a gestão de alunos: página principal, gestão de formulário, a lista de alunos, 
#a página de atualização, exclusão...

Go To Form Students
    Click       css=a[href$="alunos/new"]
    # checkpoint
    Wait For Elements State         css=h1 >> text=Novo aluno     visible         5 
    #clicou e foi para a subpágina "Novo aluno"


Go To Student Update Form
    [Arguments]         ${email}
# Elemento do tipo "a" que deve ter a função de editar cadastro 
    Click                       xpath=//td[contains(text(), "${email}")]/..//a[@class="edit"]
    # Checkpoint
    Wait For Elements State     css=h1 >> text=Edição de aluno     visible         5 


Request Removal by Email  ##remove o registro pela chave email 
    [Arguments]     ${email}
    Click           xpath=//td[contains(text(), "${email}")]/../td//button[@id="trash"]

Confirm Removal
    Click           text=SIM, pode apagar!

Cancel Removal
    Click           text=NÃO

## Validations
Student Should Not Visible
    [Arguments]                 ${email}

    Wait For Elements State     xpath=//td[contains(text(), "${email}")]   detached     5
    ##5 seg para não encontrar uma td com o email que estou passando 

    ##estado "detached" usado nessa keyword para validar se um elemento não existe no html
    ##detached - contrario do visible

Student Should Be Visible
    [Arguments]                 ${email}

    Wait For Elements State     xpath=//td[contains(text(), "${email}")]    visible     5
    ##5 seg para  encontrar uma td com o email que estou passando 

Student Name Should Be Visible  ##O table nome visivel deve estar visivel por 5 seg.
    [Arguments]                     ${name}

    Wait For Elements State         css=table tbody tr >> text=${name}


Search Student By name
    [Arguments]         ${name}

    Fill Text           css=input[placeholder="Buscar aluno"]           ${name}    





    
