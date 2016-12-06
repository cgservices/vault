# Vault

## Presenstation
See HowVaultWorks.key

## Installation Requirements
- Docker: https://docs.docker.com/docker-for-mac/

## Installation
- Install vault with brew (Mac OS):<br>
`brew install vault`
- Clone this Git repository to your project folder.
- Change the volume locations in the _docker-compose.yml_ to your project folder location.
- Set environment settings in Bash to talk to the Vault Docker container.<br>
`export VAULT_ADDR='http://127.0.0.1:8200'`<br>
`export VAULT_AUTH_METHOD=token`<br>
- Make a data folder in the vault application folder.<br>
`mkdir data`
- Make also a data log folder<br>
`mkdir logs`

### Start Docker Vault
- Navigate to your vault application folder.
- Starting Docker Vault:
`docker-compose up -d`

### Stop Docker Vault
- Navigate to your vault application folder.
- Stop Docker Vault:
`docker-compose stop`

### Initializing Vault server
- For initializing the Vault server, execute the following command:<br>
`vault init`
- Store the unseal keys and token to your personal password storage tool.
- Unseal the vault with your unseal keys and the following command.<br>
`vault unseal <Unseal key>`<br>
 _Vault uses three unseal keys to open the vault._
- Set token environment setting in Bash.<br> 
`export VAULT_TOKEN=<token>`<br>
`export VAULT_AUTH_TOKEN=<token>`<br>
You can also add these settings to your own _~/.bashrc_ or _~/.zshrc_.
- Authenticate to Vault.<br>
`vault auth <token>`
- Add Vault policies with the following commands:<br>
`vault mount generic`<br>
`vault policy-write secret ./policies/secret.hcl`<br>
`vault token-create -policy="secret"`<br>

#### Vault Policies
- Add Vault policy for Omnia (Recharge) application.
`vault policy-write omnia ./policies/omnia.hcl`<br>
`vault token-create -policy="omnia"`<br>

##### Enable GitHub Access
To authenticate Vault with your Git account, follow the next steps:
- Add Github authentication.<br>
`vault auth-enable github`
- Grant authentication for CG.<br>
`vault write auth/github/config organization=cgservices`
- Add policies to CG github accounts.
`vault write auth/github/map/teams/development policies=secret,omnia`

##### Authenticate with Github account
- Access your Personal Access Tokens in GitHub at https://github.com/settings/tokens. Generate a new Token that has the scope _read:org_. Save the generated token. This is what you will provide to vault.
- Set the following environment settings:<br>
`export VAULT_AUTH_METHOD=github`<br>
`export VAULT_AUTH_GITHUB_TOKEN=<Git Token>`
- Authenticate with Github account.<br>
`vault auth -method=github`

## Test
Here is an example to write and reading to your Vault.
- Writing to Vault.<br>
`vault write secret/omnia/test value=yes`
- Reading from Vault.<br>
`vault read secret/omnia/test`

## FAQ

##### How to run docker-compose for Vault at bootup
- Open your terminal
- Open your crontab
`crontab -e`
- Add the following line with your favorite editor:<br>
EXAMPLE:<br>
`@reboot docker-compose /Users/pmartens/Projects/Docker/vault/docker-compose.yml up -d`

##### Rails gem for Vault integration in rails applications
 Gem for Vault integration in rails applications:
 https://github.com/infinum/secrets_cli
