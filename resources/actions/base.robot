***Settings***
Documentation   Tudo começa aqui, meu arquivo base do projeto de automação

library      Browser
Library      Collections   ##Biblioteca está sendo adicionada para utilizar a KEYWORD "Append To List" e "List Should be equal" no cenário "Todos os campos devem ser obrigatorios"               
Library      OperatingSystem  # Biblioteca para usar keyword Get File - sistema operacional
Library      DateTime       # Biblioteca para datas
Library      ../libs/DeloreanLibrary.py

Resource    ../actions/auth.robot
Resource    ../actions/enrolls.robot
Resource    ../actions/students.robot
Resource    ../actions/plans.robot
Resource    ../actions/nav.robot
Resource    ../actions/components.robot


***Keywords***
Start Browser Session
    New Browser     chromium        false  ##define o navegador
    New Page        about:blank    ###abre a página em branco / cria a sessão em branco  

Start Admin Session
    Start Browser Session
    Go To Login Page 
    Login With                  admin@bodytest.com  pwd123
    User Should Be Logged In    Administrador

Clear Local Storage and Take Screenshot   ##Limpar o Local Storage e Tirar o print da tela 
    Take Screenshot
    LocalStorage Clear     

Thinking And Take Screenshot
    [Arguments]         ${timeout}

    Sleep               ${timeout}
    Take Screenshot
    

##helpers  - sistema operacional
Get JSON 
    [Arguments]         ${file_name}

    # Get File - Keyword da biblioteca de sistemas operacionais - dá acesso ao recursos do S.O
    # Lê o conteudo do arquivo atraves do get file 

    ${file}=            Get File    ${EXECDIR}/resources/fixtures/${file_name}  # Salva o conteúdo na variavel ${file} como string 
    # Acessa ao parâmetro para converter o conteúdo do arquivo file (string) para o formato json 
    ${json_object}      Evaluate    json.loads($file)       json
    #Log To Console      ${json_object['students']}  ##para saber se esta funcionando
    [return]            ${json_object}  ## devolve o resultado json para variavel ${fixture}
   
# ${json_object} -> Super variavel : possui várias massa de testes numa variavel so, varios objetos .

