# web_pdb
Aplicação Web do Prontuário do Busão.

 Executar projeto em modo DEV usando o DOCKER
- Execute as permissões nos scripts
```
chmod +x ./api_pdb/docker/dev-entrypoint
chmod +x ./api_pdb/docker/test-entrypoint
``` 
- Copie o arquivo .dev.sample para definição da variaveis de ambiente
```
cp .env.sample .env.dev
```

- Excute o script up_dev na raiz do projeto
```
sh up_dev.sh 
```
- Verifique se todos os serviços foram iniciados
```
docker-compose logs -f -t 
```

- Visite o endereço
```
http://localhost:3003 
