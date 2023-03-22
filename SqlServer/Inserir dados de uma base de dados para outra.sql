SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].'NOME DO TRIGGER'
				on [dbo].'Tabela']
				for insert
				as
				BEGIN

				INSERT INTO 'Base de dados a receber os valores'..'Tabela'( )

select   *  from 'de onde vai sair os dados'..'Tabela' where 'condição para verificar dados' not in (SELECT 'um unico campos a retornar' from 'base de dados'..'tabela'  ) 
AND NO not in (SELECT 'campo' from 'tabela'..'tabela'  )


				

				End