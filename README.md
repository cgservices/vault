# Vault

## Installation
- Install vault with brew (Mac OS):<br>
`brew install vault`
- Set environment settings in Bash to talk to Vault Docker container.<br>
`export VAULT_ADDR='http://127.0.0.1:8200'`<br>
`export VAULT_AUTH_METHOD=token`<br>
- Make data folder in vault folder.<br>
`mkdir data`
- Make log folder<br>
`mkdir logs`

### Initializing Vault server
- For initializing the Vault server, execute the following command:<br>
`vault init`
- Store the unseal keys and token to your personal password storage tool.
- Unseal the vault with your unseal keys and the following command.<br>
`vault unseal <Unseal key>`<br>
 Vault uses three unseal keys to open the vault.
- Set token environment setting in Bash.<br> 
`export VAULT_TOKEN='<token>`<br>
`export VAULT_AUTH_TOKEN='<token>'`<br>
- Authenticate to Vault.<br>
`vault auth <token>`
- Add Vault policies with the following commands:<br>
`vault mount generic`<br>
`vault policy-write secret ./policies/secret.hcl`<br>
`vault token-create -policy="secret"`<br>
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
`export VAULT_AUTH_GITHUB_TOKEN='<Git Token'`
- Authenticate with Github account.<br>
`vault auth -method=github`

## Test
Here is an example to write and reading to your Vault.
- Writing to Vault.<br>
`vault write secret/omnia/test value=yes`
- Reading from Vault.<br>
`vault read secret/omnia/test`
