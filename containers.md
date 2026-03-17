# Uso de containers na disciplina

Nesta disciplina utilizamos **containers (Apptainer)** para executar ferramentas de bioinformática de forma **reprodutível e independente do sistema operacional**.

Isso significa que todos os alunos utilizarão exatamente as mesmas versões de software, evitando problemas de instalação e compatibilidade.

# O que é um container?

Um container é um ambiente isolado que contém:

- programas (ex: BLAST, Flye, FastQC)
- bibliotecas
- dependências

Sem interferir no seu sistema operacional.

# Por que usamos containers?

Bioinformática depende de muitos softwares com dependências complexas.

Containers permitem:

- evitar conflitos entre versões
- garantir que todos tenham o mesmo ambiente
- facilitar reprodutibilidade dos resultados

# Instalação do Apptainer

Em sistemas baseados em Ubuntu/Debian:

```bash
sudo add-apt-repository -y ppa:apptainer/ppa
sudo apt update
sudo apt install -y apptainer squashfs-tools apptainer-suid
```

Verifique a instalação:

```bash
apptainer --version
```

# Construindo uma imagem

As imagens são definidas por arquivos .def.

Exemplo:

```bash
sudo apptainer build cen5789-core.sif cen5789-core.def
```

- .def: descreve o ambiente
- .sif: imagem final

> [!IMPORTANT]
> A construção requer sudo pois envolve criação de sistema de arquivos.

# Executando comandos

Para executar um programa dentro do container:

```bash
apptainer exec cen5789-core.sif blastn -version
```

# Acessando um shell interativo

```bash
apptainer shell cen5789-core.sif
```

Depois disso, você pode usar os comandos normalmente:

```bash
blastn -version
fastqc --help
```
# Acesso a arquivos

O Apptainer automaticamente acessa os arquivos do seu diretório atual.
Por exemplo, crie a pasta files, e desarrege dentro dela o arquivo [Python_04.fasta](files/Python_04.fasta)

```bash
cd
mkdir -p files
cd files
wget https://raw.githubusercontent.com/labbces/cen5789/refs/heads/main/files/Python_04.fasta
cd
```

Agora vamos usar o container para criar um banco de dados compativel com blast:

```bash
apptainer exec /data/cen5789_containers/cen5789-core.sif makeblastdb -in files/Python_04.fasta -dbtype nucl
```

# Problemas comuns

## Permissão negada ao construir

Use:

```bash
sudp apptainer build ...
```

## Falta de espaço

Imagens podem ter vários GB.

Verifique:

```bash
df -h
```

## Comando não encontrado

Verifique se está usando:

```bash
apptainer exec imagem.sif comando
```

# Boas práticas

- não instale softwares manualmente no sistema
- use sempre os containers fornecidos
- mantenha os arquivos .def organizados
- registre versões dos programas usados

# Referências

- https://apptainer.org/docs/
