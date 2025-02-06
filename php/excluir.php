<?php

include("./config.php");

$conexao = mysqli_connect($host, $login, $senha, $bd);
$sql = "DELETE FROM Produtos WHERE SKU =".$_GET["sku"];

mysqli_query($conexao, $sql);
mysqli_close($conexao);

header("location: ./index.php");

?>