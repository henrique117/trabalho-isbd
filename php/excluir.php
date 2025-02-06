<?php

include("./config.php"); # Importar o arquivo de configuração

$conexao = mysqli_connect($host, $login, $senha, $bd); # Cria uma conexão com o banco de dados
$sql = "DELETE FROM Produtos WHERE SKU =".$_GET["sku"]; # SQL

mysqli_query($conexao, $sql); # Roda o SQL no banco de dados conectado
mysqli_close($conexao); # Fecha a conexão com o banco de dados

header("location: ./index.php"); # Redireciona o header para o index.php

?>