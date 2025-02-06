<?php

include("./config.php");

$conexao = mysqli_connect($host, $login, $senha, $bd);

if(isset($_POST["sku"])) {
    $sql = "UPDATE Produtos SET nome = '".$_POST["nome"]."', descricao = '".$_POST["descricao"]."', valor = ".$_POST["valor"].", categoria = '".$_POST["categoria"]."' WHERE SKU = ".$_POST["sku"]."";
} else {
    $sql = "INSERT INTO Produtos (nome, descricao, valor, categoria) VALUES ('".$_POST["nome"]."', '".$_POST["descricao"]."', ".$_POST["valor"].", '".$_POST["categoria"]."')";
}

mysqli_query($conexao, $sql);
mysqli_close($conexao);

header("location: ./index.php");

?>