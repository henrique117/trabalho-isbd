<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Formulario</title>
</head>
<body>

    <form action="incluir.php" method="POST">

        <?php

        include("./config.php");

        $conexao = mysqli_connect($host, $login, $senha, $bd);
        $result = [0, '', '', 0.00, ''];

        if(isset($_GET["sku"])) {

            $sql = "SELECT * FROM Produtos WHERE SKU = ".$_GET["sku"]."";
            $tabela = mysqli_query($conexao, $sql);
            $result = mysqli_fetch_row($tabela);

            ?>
            <input type="hidden" name="sku" value="<?php echo $_GET["sku"]; ?>">
            <h1>Editar registro</h1>
            <?php
        } else {
            ?>
            <h1>Inserir registro</h1>
            <?php
        }

        ?>

        <div class="container">
            <div class="span-div">
                <label for="nome">Nome do produto:</label>
                <input class="text-input" type="text" name="nome" value="<?php echo $result[1]; ?>" required>
            </div>
            <div class="span-div">
                <label for="nome">Descricao do produto:</label>
                <input class="text-input" type="text" name="descricao" value="<?php echo $result[2]; ?>" required>
            </div>
            <div class="span-div">
                <label for="nome">Valor do produto:</label>
                <input class="text-input" type="number" name="valor" step="0.01" min="0" value="<?php echo $result[3]; ?>" required>
            </div>
            <div class="span-div">
                <label for="nome">Categoria do produto:</label>
                <input class="text-input" type="text" name="categoria" value="<?php echo $result[4]; ?>" required>
            </div>

            <div class="form-buttons">
                <input class="button-geral button-red" type="button" value="Cancelar" onclick="location.href='index.php'">
                <input class="button-geral button-blue" type="submit" value="Enviar">
            </div>
        </div>
    </form>
</body>
</html>