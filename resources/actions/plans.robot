***Settings***
Documentation       Ações da feature de gestão de planos

***Variables***  ##so crio essa estrutura dentro do app actions se for necessário 
${TITLE_FIELD}      id=title
${DURATION_FIELD}   id=duration
${PRICE_FIELD}      css=input[name=price]
${TOTAL_FIELD}      css=input[name=total]

***Keywords***
## Forms
Submit Plan Form  ## submete formulário de aluno 
   Click           xpath=//button[contains(text(), "Salvar")]   ## evento de click


Fill Plan Form  # Preenche Form de Plano
    [Arguments]     ${plan}
    #${title}     ${duration}       ${price} 

    Fill Text       ${TITLE_FIELD}         ${plan.title}
    Fill Text       ${DURATION_FIELD}      ${plan.duration}
    Fill Text       ${PRICE_FIELD}         ${plan.price}
    

New Plan
    [Arguments]     ${plan}
  
    Fill Text       ${TITLE_FIELD}         ${plan.title}
    Fill Text       ${DURATION_FIELD}      ${plan.duration}
    Fill Text       ${PRICE_FIELD}         ${plan.price}

    Submit Plan Form  

Update A Plan
    [Arguments]     ${plan}
   
    #Log To Console   ${plan}
    Fill Text       ${TITLE_FIELD}         ${plan['title']}
    Fill Text       ${DURATION_FIELD}      ${plan['duration']}
    Fill Text       ${PRICE_FIELD}         ${plan['price']}

    Submit Plan Form   

## Links & Buttons
Go To Form Plan
    Click       css=a[href$="planos/new"]
    # checkpoint
    Wait For Elements State         css=h1 >> text=Novo plano     visible         5   
    #clicou e foi para a subpágina "Novo aluno"

Request Removal by Title  ##remove o registro pela chave email 
    [Arguments]     ${title}
    Click           xpath=//td[contains(text(), "${title}")]/../td//button[@id="trash"]

Confirm Removal Plan
    Click           text=SIM, pode apagar!

Cancel Removal Plan
    Click           text=NÃO

Plan Should Be Visible
    [Arguments]                 ${title}

    Wait For Elements State     xpath=//td[contains(text(), "${title}")]    visible     5
    ##5 seg para  encontrar uma td com o email que estou passando 

Go To Plan Update Form
    [Arguments]                 ${title}
# Elemento do tipo "a" que deve ter a função de editar cadastro 
    Click                       xpath=//td[contains(text(), "${title}")]/..//a[@class="edit"]
    # Checkpoint
    Wait For Elements State     css=h1 >> text=Edição de plano     visible         5 
    Sleep                       1

# Validations 
# Validar e garantir que o valor calculado é o resultado esperado 
Total Plan Should Be 
    [Arguments]     ${total}
    # Obter o campo total_field passando o atributo "value", que possui o valor calculado
    Get Attribute       ${TOTAL_FIELD}      value    ==     ${total}  

Search Plan By Title
    [Arguments]         ${title}

    Fill Text           css=input[placeholder="Buscar plano"]           ${title} 

Plan Should Not Visible
    [Arguments]                 ${title}

    Wait For Elements State     xpath=//td[contains(text(), "${title}")]   detached     5
    # 5 seg para não encontrar uma td com o title que estou passando 

    ##estado "detached" usado nessa keyword para validar se um elemento não existe no html
    ##detached - contrario do visible
   

    
