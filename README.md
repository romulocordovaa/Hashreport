# 🔎 Hashreport V1.1
Bash script desenvolvido para automatizar processo de aquisição do hash com algoritmos SHA-512 ou MD5, o diferencial seria a saída dos dados por meio de um relatorio em formato txt, o bash script foi feito no período de estagio na Polícia Científica do Pará, para ser utlizado para auxiliar no processo de forense digital.

# ❗ Pré-requisito
Apenas é necessário habilitar o som do terminal, para que ao final do precesso o alerta sonoro funcione.

# 💻 Baixar o Hashreport
Se você prefirir pode baixar o scrpit clicando [aqui](https://downgit.github.io/#/home?url=https://github.com/romulocordovaa/Hashreport/blob/main/hashreport.sh). Ou  clonar o repositório Git:
```
https://github.com/romulocordovaa/Hashreport.git
```
# ⚙️ Uso
O primeiro passo e alterar as permissões do arquivo, para que ele possa ser executado:
```
chmod +x hashreport.sh
```
Para iniciar o scrpit:
```
sudo ./hashreport.sh
```
Para acessar a ajuda basta iniciar o scrpit acompanhado de -h ou --help, onde mostrar tambem o -v ou --version que mostra qual a versão esta em uso. 
```
./hashreport.sh -h
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/92320996/183473171-0b6c83bf-209e-409f-8713-1c31f914e310.png" />
</p>
Ao iniciar o scrpit ele vai listar todos os dispositvios e suas partições da maquina

<p align="center">
  <img src="https://user-images.githubusercontent.com/92320996/184411111-c4b7c548-94ea-48a7-b727-a61fb8747131.png" />
</p>

Após isso as unicas informações que vai ter que ser passadas na seguinte respectiva ordem:
- Deseja realizar hash no dispositivo que faz de todas as partiçõe ou apenas de partições especificas

- Tipo de hash MD5 ou SHA-512
<p align="center">
  <img src="https://user-images.githubusercontent.com/92320996/184418193-e40f4301-fdcb-4217-a3b3-605984e0198b.png" />
</p>

- O Caminho do arquivo que será  salvo as informações
<p align="center">
  <img src="https://user-images.githubusercontent.com/92320996/184418189-65cf3ee6-f3f4-44ed-b7d5-5147f7deb8b6.png" />
</p>
- Se existir algum arquivo criado com o mesmo nome, vai ser perguntado se deseja apagar o conteudo e escrever um novo, caso contrario o scrpit é encerrado.
<p align="center">
  <img src="https://user-images.githubusercontent.com/92320996/184418179-b116de50-0e04-419a-8cbc-af4e25feb141.png" />
</p>
- Depois disso o processo e inciado e no fim, o alerta sonoro será ativado, 00

Ao finalizar o processo sera gerado um relatorio igual ao apresentado abaixo:
<p align="center">
  <img src="https://user-images.githubusercontent.com/92320996/183475682-4cbe01c4-95aa-49d9-907a-2afef78ef8eb.png" />
</p>

# 💬 Contato
romulo81@yahoo.com.br
