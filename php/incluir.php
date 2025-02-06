<?php

include("./config.php"); # Importar o arquivo de configuração

$conexao = mysqli_connect($host, $login, $senha, $bd); # Cria uma conexão com o banco de dados

if(isset($_POST["sku"])) { # Verifica se o formulário tinha o sku (editar) ou não (inserir)
    $sql = "UPDATE Produtos SET nome = '".$_POST["nome"]."', descricao = '".$_POST["descricao"]."', valor = ".$_POST["valor"].", categoria = '".$_POST["categoria"]."' WHERE SKU = ".$_POST["sku"].""; # SQL
} else {
    $sql = "INSERT INTO Produtos (nome, descricao, valor, categoria) VALUES ('".$_POST["nome"]."', '".$_POST["descricao"]."', ".$_POST["valor"].", '".$_POST["categoria"]."')"; # SQL
}

mysqli_query($conexao, $sql); # Roda o SQL no banco de dados conectado
mysqli_close($conexao); # Fecha a conexão com o banco de dados

header("location: ./index.php"); # Redireciona o header para o index.php

?>