***Settings***
Documentation       Suite Remover planos

Resource    ${EXECDIR}/resources/actions/base.robot

# criar uma sessão do navegador uma única vez / realiza os testes em uma única sessão
Suite Setup     Start Admin Session  # cria a sessão do navegador e faz o login como administrador 
                # keyword base.robot
                # pré-condição para Login 

#Screenchot para todos os testes, tirar o print sempre no final de todos os cenário de testes dessa suite
Test Teardown   Take Screenshot


***Test Cases***
Cenário: Remover plano cadastrado
    
    &{plan}     Create Dictionary       title=Plano Mensal      duration=1     price=19.99     total=R$ 19,99

    Insert Plan                 ${plan}
    Go To Plans  
    Search Plan By Title        ${plan.title}
    #Sleep           5
    Request Removal by Title    ${plan.title}
    Confirm Removal Plan
    Toaster Text Should Be      Plano removido com sucesso
    Plan Should Not Visible     ${plan.title}   # VALIDA SE O USUARIO REMOVIDO SUMIU DA PAGINA

Cenário: Desistir da exclusão
    [tags]      rm
    &{plan}     Create Dictionary       title=Plano Full      duration=12     price=109.90     total=R$ 1318,80

    Insert Plan                 ${plan}
    Go To Plans
    Search Plan By Title        ${plan.title} 
    Request Removal by Title    ${plan.title}  
    Cancel Removal Plan
    Plan Should Be Visible      ${plan.title}