class EleicoesController < ApplicationController

	#retorna
	#id, apelido, nome, (numero, titulo, matricula, cargo, estado, partido, idade, isntrucao, ocupacao, miniBio, cargos, reeleicao, foto, casaAtual, previsao, bancadas
	def listarCandidatos 
		
		vars = ""
		optional_param = ""

		@tipoBusca = 1

		if params[:id]
			optional_param = "/" + params[:id]
			@tipoBusca = 2
		else
			vars = {"estado" => params[:estado], "partido" => params[:partido], "cargo" => params[:cargo], "nome" => params[:nome]}
		end

		@candidatos = getDataFromAPI("candidatos" + optional_param, vars)

	end


	#retorna
	#bem, montante, ano
	def listarBensCandidato
		
		if params[:id]
			@bens = getDataFromAPI("candidatos/"+params[:id]+"/bens")
		end
		
	end

	#retorna
	#nome, cgc, montante
	def listarDoadoresCandidato
		
		if params[:id]
			if params[:ano]
				vars = {"anoEleitoral" => params[:ano]}
				@doadores = getDataFromAPI("candidatos/"+params[:id]+"/doadores",vars)
			end
		end
		
	end

	#retorna
	#anoEleitoral, cargo, partidoSigla, municipio, estadoSigla, resultado, votosObtidos, recursosFinanceiros
	def listarCandidaturasCandidato
		
		if params[:id]
			@candidaturas = getDataFromAPI("candidatos/"+params[:id]+"/candidaturas")
		end
		
	end

	#retorna
	#faltas_plen, media_plen, faltas_com, media_com, evol, ano_ref, emendas, media_emendas
	def listarEstatisticasCandidato
		
		if params[:id]
			@estatisticas = getDataFromAPI("candidatos/"+params[:id]+"/estatisticas")
		end
		
	end


	#retorna
	#partidoId, sigla
	def listarPartidos
		@partidos = getDataFromAPI("partidos")
			
	end

	#retorna
	#estadoId, sigla, nome
	def listarEstados
		@estados = getDataFromAPI("estados")
			
	end

	#retorna
	#cargoId, nome
	def listarCargos
		@cargos = getDataFromAPI("cargos")

	end

	def getDataFromAPI(url = "", vars = nil)

		return HTTParty.get(
				Constants::API_URL + url, 
				:query => vars,
				:headers => {"App-Token" => Constants::APP_TOKEN, "Content-Type" => "application/json", "Accept" => "application/json"}
				)
	end
end
