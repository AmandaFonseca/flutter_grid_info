# flutter_grid_info 
Aplicativo Flutter para registro de informações e visualização de gráficos de edições.

## Pacotes usados
- mobx & flutter_mobx: usados para gerenciar o estado reativo nas telas.
- mobx_codegen & build_runner: Para automatizar o processo de .g.dart
- dartz: Para retorno padronizado de falhas ou sucessos.
- equatable: Para comparar a comparação de objetos.
- shared_preferences: Persistência de dados simples no dispositivo.
- flutter_dotenv: Gerencia variáveis de ambiente (como e-mail e senha padrão).
- fl_chart: Biblioteca de gráficos para Flutter.
- Google Fonts: Mais pode de escolha de fontes. 

## Como Executar o Projeto

1. **Clone o repositório**
    ```bash
        https://github.com/AmandaFonseca/flutter_grid_info.git
    ```   
        
2.  **Configure as Variáveis de Ambiente**
   Crie um arquivo .env no diretório raiz:
    ```bash
        LOGIN_EMAIL=seu_email@teste.com
        LOGIN_PASSWORD=sua_senha_aqui
    ```   

    ⚠️ **Nota de Segurança:**: O projeto utiliza variáveis de ambiente. Caso o arquivo não seja criado, o sistema utiliza as credenciais padrão:

    - E-mail: admin@targetsistemas.com
    - Senha: senha@1234


3.  **Instale as dependências**

    ```bash
        flutter pub get
    ```   

4.  **Gere os arquivos do MobX**
    Este comando é essencial para gerar o código reativo das Stores:
    ```bash
        dart run build_runner build --delete-conflicting-outputs
    ```   

5.  **Execute o app**
    ```bash
        flutter run
    ```   
