<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Index</title>
</head>
<body>
    
    <h1>PRODUTOS</h1>

    <div class="container">
        <?php
        include("./config.php"); # Importar o arquivo de configuração

        $conexao = mysqli_connect($host, $login, $senha, $bd); # Cria uma conexão com o banco de dados
        $sql = "SELECT * FROM Produtos ORDER BY SKU"; # SQL
        
        $tabela = mysqli_query($conexao, $sql); # Roda o SQL e salva os resultados em uma tabela

        ?>
        <table>
        <?php

        if(mysqli_num_rows($tabela) == 0) { # Checa se existe registros na tabela
            ?>
            <h3>Nao existe nenhum produto cadastrado!</h3>
            <?php
        } else {
            ?>
            <tr>
                <th>SKU</th>
                <th>Nome</th>
                <th>Descricao</th>
                <th>Valor</th>
                <th>Categoria</th>
                <th>Opcoes</th>
            </tr>
            <?php
            while($data = mysqli_fetch_row($tabela)) { # Para cada linha da tabela, extrai os dados e armazena no vetor $data
                ?>
                <tr>
                    <td><?php echo $data[0]; ?></td>
                    <td><?php echo $data[1]; ?></td>
                    <td><?php echo $data[2]; ?></td>
                    <td><?php echo $data[3]; ?></td>
                    <td><?php echo $data[4]; ?></td>
                    <td class="td-acoes">
                        <input class="button-td button-red" type="button" value="Excluir" onclick="location.href='excluir.php?sku=<?php echo $data[0]; ?>'">
                        <input class="button-td button-blue" type="button" value="Editar" onclick="location.href='form_incluir.php?sku=<?php echo $data[0]; ?>'">
                    </td>
                </tr>
                <?php
            }
        }

        mysqli_close($conexao); # Fecha a conexão com o banco de dados
        ?>

        <input class="button-geral button-blue" type="button" value="Inserir novo produto" onclick="location.href='form_incluir.php'">
    </div>

</body>
</html>