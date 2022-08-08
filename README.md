# 🔎 Hashreport
Bash scrpit desenvolvido para automatizar processo de hash sha512sum e md5sum e a saída dos dados se da por meio de um relatorio em formato txt, o bash scrpit foi desenvolvido no estagio na Polícia Científica do Pará, com a ajuda do périto Natanael, para ser utlizado como uma ferramente que auxilia no processo de forense computacional.

# ❗ Pré-requisito
O unico requisito necessário e baixar o Pulseaudio para possiblitar o alerta sonoro do scrpit para sinalizar o fim do processo.

### Instalar pulseaudio usando apt

O primeiro passo é atualiza a lista de pacotes e programas que podem ser instalados na máquina:
```
sudo apt update && sudo apt upgrade
```
Após atualizar o banco de dados do apt, podemos instalar o pulseaudio usando o apt executando o seguinte comando:
```
sudo apt install pulseaudio
```
# 💻 Baixar o Hashreport
Pode baixar o arquivo clicando [aqui](https://www.genome.gov/). Se você preferir, você pode clonar o repositório Git:
```
https://github.com/romulocordovaa/Hashreport.git
```
# ⚙️ Uso
- Após baixar o primeiro passo e alterar as permissões do arquivo, para que ele possa ser executado:
```
chmod +x hashreport.sh
```
- Para iniciar o scrpit:
```
sudo ./hashreport.sh
```
- Para acessar a ajuda basta iniciar o scrpit acompanhado de -h ou --help, onde mostrar tambem o -v ou --version que mostra qual a versão esta em uso. 
```
./hashreport.sh -h
```
```
./hashreport.sh --help
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/92320996/183473171-0b6c83bf-209e-409f-8713-1c31f914e310.png" />
</p>

- Ao finalizar o processo sera gerado um relatorio igual ao apresentado abaixo:
<p align="center">
  <img src="https://user-images.githubusercontent.com/92320996/183475682-4cbe01c4-95aa-49d9-907a-2afef78ef8eb.png" />
</p>

# 💬 Contato
romulocordovaa@gmail.com
