#1º passo: criar arquivo de políticas de segurança (politivas.json)

#2º passo: criar role de segurança na AWS
aws iam create-role \
  --role-name lambda-exemplo \
  --assume-role-policy-document file://politicas.json \
  | tee logs/role.log

#3º passo: criar arquivo js com conteúdo e zipa-lo
zip function.zip index.js

aws lambda create-function \
  --function-name hello-cli \
  --zip-file fileb://function.zip \
  --handler index.handler \
  --runtime nodejs12.x \
  --role arn:aws:iam::370335670914:role/lambda-exemplo \
  | tee logs/lambda-create.log

#4º passo: invocar a lambda
aws lambda invoke \
  --function-name hello-cli \
  --log-type Tail \
  logs/lambda-exec.log

#Atualizar: 

#zipar novamente
zip function.zip index.js

#atualizar lambda
aws lambda update-function-code \
  --function-name hello-cli \
  --zip-file fileb://function.zip \
  --publish \
  | tee logs/lambda-update.log

#5º passo: remover
aws lambda delete-function \
  --function-name hello-cli \

aws iam delete-role \
  --role-name lambda-exemplo \



