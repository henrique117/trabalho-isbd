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

        include("./config.php"); # Importar o arquivo de configuração

        $conexao = mysqli_connect($host, $login, $senha, $bd); # Cria uma conexão com o banco de dados
        $result = [0, '', '', 0.00, '']; # Inicia o vetor de resultado para preencher os campos caso o usuário vá editar um item

        if(isset($_GET["sku"])) { # Checa se ele clicou no botão de editar ou de inserir (Se existir o parâmetro sku significa que ele clicou no botão editar)

            $sql = "SELECT * FROM Produtos WHERE SKU = ".$_GET["sku"].""; # SQL
            $tabela = mysqli_query($conexao, $sql); # Roda o SQL e salva os resultados em uma tabela
            $result = mysqli_fetch_row($tabela); # Coloca os dados da tabela em um vetor

            ?>
            <input type="hidden" name="sku" value="<?php echo $_GET["sku"]; # Aqui ele adiciona o sku do item que vai ser editado no formulário pra passar para a função de incluir?>">
            <h1>Editar registro</h1>
            <?php
        } else {
            ?>
            <h1>Inserir registro</h1>
            <?php
        }

        mysqli_close($conexao); # Fecha a conexão com o banco de dados
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