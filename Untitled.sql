CREATE TABLE `Usuarios` (
  `id` INT PRIMARY KEY,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) UNIQUE NOT NULL,
  `senha_hash` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(14) UNIQUE NOT NULL,
  `telefone` VARCHAR(20),
  `endereco` TEXT,
  `data_nascimento` DATE,
  `status` ENUM(ativo,inativo) DEFAULT 'ativo',
  `tipo_usuario` ENUM(admin,usuario) DEFAULT 'usuario',
  `created_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP',
  `updated_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE `Clientes` (
  `id` INT PRIMARY KEY,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) UNIQUE,
  `cpf_cnpj` VARCHAR(20) UNIQUE NOT NULL,
  `telefone` VARCHAR(20),
  `endereco` TEXT,
  `cidade` VARCHAR(50),
  `estado` VARCHAR(2),
  `cep` VARCHAR(10),
  `data_cadastro` DATE DEFAULT 'CURRENT_DATE',
  `limite_credito` DECIMAL(10,2),
  `status` ENUM(ativo,inativo) DEFAULT 'ativo',
  `categoria` VARCHAR(50),
  `observacoes` TEXT,
  `contato_responsavel` VARCHAR(100),
  `setor` VARCHAR(50),
  `created_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP',
  `updated_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE `Fornecedor` (
  `id` INT PRIMARY KEY,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) UNIQUE,
  `telefone` VARCHAR(20),
  `endereco` TEXT,
  `cidade` VARCHAR(50),
  `estado` VARCHAR(2),
  `cep` VARCHAR(10),
  `cnpj` VARCHAR(20) UNIQUE NOT NULL,
  `created_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP',
  `updated_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE `Controle_Contatos_Cliente` (
  `id` INT PRIMARY KEY,
  `cliente_id` INT NOT NULL,
  `tipo_contato` ENUM(email,telefone,whatsapp) NOT NULL,
  `contato` VARCHAR(150) NOT NULL,
  `descricao` TEXT,
  `status` ENUM(ativo,inativo) DEFAULT 'ativo',
  `responsavel` VARCHAR(100),
  `criado_por` INT,
  `atualizado_por` INT,
  `created_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP',
  `updated_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE `Receitas` (
  `id` INT PRIMARY KEY,
  `cliente_id` INT NOT NULL,
  `descricao` TEXT,
  `valor` DECIMAL(10,2) NOT NULL,
  `data_recebimento` DATE NOT NULL,
  `metodo_pagamento` ENUM(dinheiro,cartao,transferencia) NOT NULL,
  `status` ENUM(pendente,recebido) DEFAULT 'pendente',
  `categoria` VARCHAR(50),
  `created_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP',
  `updated_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE `Despesas` (
  `id` INT PRIMARY KEY,
  `fornecedor_id` INT NOT NULL,
  `descricao` TEXT,
  `valor` DECIMAL(10,2) NOT NULL,
  `data_vencimento` DATE NOT NULL,
  `status` ENUM(pendente,pago) DEFAULT 'pendente',
  `categoria` VARCHAR(50),
  `metodo_pagamento` ENUM(dinheiro,cartao,transferencia) NOT NULL,
  `created_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP',
  `updated_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE `Controle_Banco` (
  `id` INT PRIMARY KEY,
  `usuario_id` INT NOT NULL,
  `banco` VARCHAR(50) NOT NULL,
  `agencia` VARCHAR(10) NOT NULL,
  `conta` VARCHAR(20) UNIQUE NOT NULL,
  `tipo_conta` ENUM(corrente,poupanca) NOT NULL,
  `saldo` DECIMAL(10,2) DEFAULT 0,
  `status` ENUM(ativo,inativo) DEFAULT 'ativo',
  `created_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP',
  `updated_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE `Controle_Cartoes` (
  `id` INT PRIMARY KEY,
  `usuario_id` INT NOT NULL,
  `banco` VARCHAR(50) NOT NULL,
  `numero_cartao` VARCHAR(20) UNIQUE NOT NULL,
  `limite` DECIMAL(10,2) NOT NULL,
  `vencimento` DATE NOT NULL,
  `created_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP',
  `updated_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE `Controle_Contas` (
  `id` INT PRIMARY KEY,
  `usuario_id` INT NOT NULL,
  `descricao` TEXT NOT NULL,
  `saldo` DECIMAL(10,2) DEFAULT 0,
  `status` ENUM(ativo,inativo) DEFAULT 'ativo',
  `created_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP',
  `updated_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE `Controle_Pagamentos` (
  `id` INT PRIMARY KEY,
  `usuario_id` INT NOT NULL,
  `descricao` TEXT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `data_pagamento` DATE NOT NULL,
  `metodo_pagamento` ENUM(dinheiro,cartao,transferencia) NOT NULL,
  `status` ENUM(pendente,pago) DEFAULT 'pendente',
  `categoria` VARCHAR(50),
  `created_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP',
  `updated_at` TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

ALTER TABLE `Controle_Contatos_Cliente` ADD FOREIGN KEY (`cliente_id`) REFERENCES `Clientes` (`id`);

ALTER TABLE `Receitas` ADD FOREIGN KEY (`cliente_id`) REFERENCES `Clientes` (`id`);

ALTER TABLE `Despesas` ADD FOREIGN KEY (`fornecedor_id`) REFERENCES `Fornecedor` (`id`);

ALTER TABLE `Controle_Banco` ADD FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`id`);

ALTER TABLE `Controle_Cartoes` ADD FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`id`);

ALTER TABLE `Controle_Contas` ADD FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`id`);

ALTER TABLE `Controle_Pagamentos` ADD FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`id`);
